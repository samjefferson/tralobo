require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
	def setup
		@user = users(:test)
	end

	test 'displayed information' do 
		log_in_as @user
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title(@user.username)
		assert_match @user.logs.count.to_s, response.body
		assert_select 'div.pagination'
		@user.logs.paginate(page: 1).each do |log|
      assert_match log.title, response.body
    end

	end

end
