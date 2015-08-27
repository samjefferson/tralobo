require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
  	@admin_user = users(:test)
  	@user = users(:sissoko) 
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test 'no destroy from non-logged in user' do
  	assert_no_difference 'User.count' do
  		delete :destroy, id: @admin_user
  	end
  	assert_redirected_to root_url
  end

  test 'no destroy from non-admin user' do
  	log_in_as(@user)
  	assert_no_difference 'User.count' do
  		delete :destroy, id: @admin_user
  	end
  	assert_redirected_to root_url
  end

end
