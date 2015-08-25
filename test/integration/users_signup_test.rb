require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'invalid signup' do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { username: ' ',
															email: 'sam@sam',
															password: 'jik',
															password_confirmation: 'lol'} 
		end	
		assert_template 'users/new'
  end

  test 'valid signup' do
  	get signup_path 
  	assert_difference 'User.count', 1 do
  		post_via_redirect users_path, user: { username: 'samjefferson',
  															email: 'sam@example.com',
  															password: 'password3',
  															password_confirmation: 'password3'}
  		end
      assert is_logged_in?
      assert_template 'users/show'
  end

end
