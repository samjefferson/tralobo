require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test 'invaid log in' do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, session: { username: ' ', password: ' '}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?

  end

  test 'valid log in' do
  	get root_path
  	assert_select 'a[href=?]', login_path
  	assert_select 'a[href=?]', signup_path
  	post login_path, session: { username: 'test1234', password: 'test1234'}
  	get root_path
  	assert_select 'a[href=?]', logout_path
  	assert_select 'a[href=?]', users_path
  end
end
