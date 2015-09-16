require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
	def setup
		@comment = comments(:test)
		@admin_user = users(:test)
		@user = users(:sissoko)
	end

	test "redirect non logged-in comment creates" do 
		assert_no_difference 'Comment.count' do
			post :create, comment: { content: "hello", user_id: 3, log_id: 2}
		end
		assert_redirected_to login_path
	end

	test "redirect non logged-in comment destroys" do
		assert_no_difference 'Comment.count' do
			post :destroy, id: @comment
		end

		assert_redirected_to root_url
	end

	test "redirect non admin user comment destroys" do
		log_in_as @user
		assert_no_difference 'Comment.count' do
			post :destroy, id: @comment
		end

		assert_redirected_to root_url
	end
end
