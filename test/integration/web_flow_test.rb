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
    r = create_incident(Incident.first)
    assert_equal 'success', r.headers['status'], 'Could not create valid incident'
    # Create an invalid incident
    r = create_incident(Incident.new(name: nil, message: nil, component: nil))
    assert_equal 'failed', r.headers['status'], 'Could create invalid incident'
  end

  def sign_in(email, password)
    post_via_redirect '/session', 'session[email]' => email, 'session[password]' => password
    return response
  end

  def create_incident(i)
    return if i.class != Incident
    post '/incidents', 'incident[name]' => i.name, 'incident[message]' => i.message, 'incident[component]' => i.component
    return response
  end

end
