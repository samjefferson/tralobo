require 'test_helper'

class LogsControllerTest < ActionController::TestCase
 
 	def setup
 		@admin_user = users(:test)
 		@user = users(:sissoko)
 		@log = logs(:most_recent)
	end

	test 'redirect non logged in creates' do 
		assert_no_difference 'Log.count' do
			post :create, log: {title: 'sam', content: 'sam', location_id: 1, user_id: 1}
		end
		assert_redirected_to login_path
	end

	test 'redirect non logged in destroys' do
		assert_no_difference 'Log.count' do
			post :destroy, id: @log
		end
		assert_redirected_to login_path
	end

	test 'no destroy from non admin user' do
		log_in_as @user
		assert_no_difference 'Log.count' do
			post :destroy, id: @log
		end
		assert_redirected_to root_path
	end

end
