require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	 def setup
    @user = users(:test)
  end

  
  test 'invaid log in' do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, session: { username: ' ', password: ' '}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?

  end

  test 'valid log in and log out' do
  	get login_path
  	post login_path, session: { username: @user.username, password: 'password1'}
  	assert is_logged_in?
  	assert_redirected_to @user
    follow_redirect!
  	assert_select 'a[href=?]', logout_path
  	assert_select 'a[href=?]', user_path
  	delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
  	assert_select 'a[href=?]', signup_path
  end
end
