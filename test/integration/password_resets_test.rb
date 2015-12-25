require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
  	ActionMailer::Base.deliveries.clear
  	@user = users(:sissoko)
  end

  test "password reset tests" do 
  	get new_password_reset_path
  	assert_template 'password_resets/new'

  	#Email address invalid check
  	post password_resets_path, password_reset:{ email:""}
  	assert_not flash.empty?
  	assert_template 'password_resets/new'

  	#valid email check
  	post password_resets_path, password_reset:{ email: @user.email}
  	assert_not_equal @user.reset_digest, @user.reload.reset_digest
  	assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email:'')
    assert_redirected_to root_url

    #wrong token
    get edit_password_reset_path("tok", email: user.email)
    assert_redirected_to root_url

    #correctload
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'

    #invald details

     patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:              "yooo",
                  password_confirmation: "bklux" }
    assert_select 'div#error_explanation'
  	#correct
  	patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:              "password1",
                  password_confirmation: "password1" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

end
