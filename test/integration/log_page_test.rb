require 'test_helper'

class LogPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  def setup
  	@log = logs(:thirty)
  end

  test "displayed information" do
 		get log_path(@log)
 		assert_template 'logs/show'
 		assert_select 'title', full_title("View Log") 
 		assert_select 'div.pagination'
 		@log.comments.paginate(page: 1).each do |comment|
 			assert_match comment.content, response.body
 		end

  end

end
