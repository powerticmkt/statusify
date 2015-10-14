require 'test_helper'

class WebFlowTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get '/'
    assert_response :success, 'Failed to get index page'
  end

  test 'sign up' do
    get '/sign_up'
    assert_response :success, 'Failed to get sign up page'
    post_via_redirect '/users', 'user[email]' => 'a@b.com', 'user[password]' => 'password'
    assert_response :success
    assert_equal 'a@b.com', User.find_by_email('a@b.com').email, 'Created user and expected user do not match.'
  end

  test 'sign in' do
    get '/sign_in'
    assert_response :success, 'Failed to get sign in page'
    # Checking with valid credentials
    sign_in(User.first.email, 'password')
    assert_response :success, 'Failed to log in in via valid credentials.'
    # Sign out
    delete '/sign_out'
    # Checking with invalid credentials
    sign_in(User.first.email, 'foobar')
    assert_response :unauthorized, 'Invalid credentials work.'
  end

  test 'create incident' do
    sign_in(User.first.email, 'password')
    get '/incidents/new'
    assert_response :success, 'Failed to get new incident page'
    # Create an incident same as the first one, provided by the fixtures
    r = create_incident(Incident.first, '/incidents')
    assert_equal 'success', r.headers['status'], 'Could not create valid incident'
    # Create an invalid incident
    r = create_incident(Incident.new(name: nil, component: nil), '/incidents')
    assert_equal 'failed', r.headers['status'], 'Could create invalid incident'
  end

  test 'modify incident' do
    sign_in(User.first.email, 'password')
    get "/incidents/#{Incident.first.id}/edit"
    assert_response :success, 'Could not get edit page'
    # Edit incident with valid parameters
    i = { name: 'Updated name', message: 'updated message', status: 'updated status', component: 'Updated component', severity: 'major' }
    r = edit_incident(i, "/incidents/#{Incident.first.id}/edit")
    assert_equal 'success', r.headers['status'], 'Could not edit valid incident'
    # Edit incident with invalid parameters
    i = { name: '', message: '', status: '', component: '', severity: '' }
    r = edit_incident(i, "/incidents/#{Incident.first.id}/edit")
    assert_equal 'failed', r.headers['status'], 'Could edit invalid incident'
  end

  test 'delete incident' do
    sign_in(User.first.email, 'password')
    # Delete valid incident
    r = delete_incident "/incidents/#{Incident.first.id}"
    assert_equal 'success', r.headers['status'], 'Could not delete invalid incident'
    # Delete invalid incident
    r = delete_incident "/incidents/#{(rand * 10_000).to_i}"
    assert_equal 'failed', r.headers['status'], 'Could delete invalid incident'
  end

  test 'deactivate incident' do
    sign_in(User.first.email, 'password')
    # Deactivate valid incident
    r = get "/incidents/#{Incident.first(2).last.id}/deactivate"
    assert_equal 'success', response.headers['status'], 'Unable to deactivate valid incident'
  end

  test 'view incident' do
    r = get "/incidents/#{Incident.first(2).last.id}"
    assert_equal nil, flash['warning']
    r = get "/incidents/#{(rand * 10_000).to_i}"
    assert_equal 'Unable to find that incident', flash['warning']
  end

  test 'subscribe' do
    # Post a valid email to the subscribe form
    post create_subscriber_path, email: 'valid-email@example.com'
    assert_equal 'Check your mail to confirm your subscription.', flash['success'], 'Considering valid emails invalid'
    # Try an invalid email
    post create_subscriber_path, email: 'bad-mail@domain'
    assert_equal 'Please check the mail address before continuing.', flash['danger'], 'Considering invalid emails valid'
  end

  test 'activate' do
    # Valid activation
    get (Statusify.app_url + '/subscribers/activate/' + Subscriber.first.activation_key)
    assert_equal "You will now receive all updates at #{Subscriber.first.email}.", flash[:success], 'Unable to activate'
    # Try an invalid one
    get (Statusify.app_url + '/subscribers/activate/' + 'invalid_activation_key')
    assert_equal 'Invalid activation key', flash[:danger], 'Activated using an invalid key.'
  end

  test 'unsubscribe' do
    # Do a valid unsubscribe
    get (Statusify.app_url + '/subscribers/unsubscribe/' + Subscriber.first.activation_key)
    assert_equal 'Unsubscribed successfully. You will no longer receive any mails from us.', flash[:success], 'Unable to unsubscribe'
    # Try an invalid one
    get (Statusify.app_url + '/subscribers/unsubscribe/' + 'invalid_activation_key')
    assert_equal 'Invalid URL. Please try again.', flash[:danger], 'Unsubscribed using an invalid key.'
  end

  def sign_in(email, password)
    post_via_redirect '/session', 'session[email]' => email, 'session[password]' => password
    response
  end

  def create_incident(i, path)
    # Path is where we send the POST request.
    return if i.class != Incident
    post path, 'incident[name]' => i.name, 'incident[events_attributes][0][message]' => 'Test Message', 'incident[component]' => i.component, 'incident[events_attributes][0][status]' => 'Test status', 'incident[severity]' => i.severity
    response
  end

  def edit_incident(i, path)
    # Path is where we send the PATCH request.
    patch path, 'incident[name]' => i[:name], 'incident[event][message]' => i[:message], 'incident[event][status]' => i[:status], 'incident[severity]' => i[:severity]
    response
  end

  def delete_incident(path)
    delete path
    response
  end
end
