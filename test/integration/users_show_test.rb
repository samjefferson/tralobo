require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

	def setup
		@admin_user = users(:test)
  	@user = users(:sissoko) 
  	@other_user = users(:colback)
  end

  test 'delete links for admin user and delete' do 
  	log_in_as(@admin_user)
  	get user_path(@user) 
  	assert_select "a[href=?]", user_path(@user), text: 'Delete Account'
  	assert_difference 'User.count', -1 do
  		delete user_path(@user)
  	end
  end

  test 'user show as none admin but logged in as current user' do
  	log_in_as(@user)
  	get user_path(@user)
  	assert_select 'a', text: 'Delete Account', count: 0
  end

  test 'not logged in' do
  	get user_path(@user)
  	assert_redirected_to root_url
  end
  	
  test 'logged in as different user' do
  	log_in_as(@other_user)
  	get user_path(@user)
  	assert_redirected_to root_url
  end
  
end
