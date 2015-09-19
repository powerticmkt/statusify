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
    post_via_redirect '/session', 'session[email]' => User.first.email, 'session[password]' => 'password'
    assert_response :success
  end

end
