require 'test_helper'

class LogTest < ActiveSupport::TestCase
  
	def setup
		@user = users(:test)
		@location = locations(:test)
		@log = @user.logs.build(title: 'My Log', content: 'This is my log about my trip somewhere', location_id: @location.id)
	end

	test 'should be valid' do 
		assert @log.valid?
	end

	test 'user_id present' do
		@log.user_id = nil
		assert_not @log.valid?
	end

	test 'location_id present' do 
		@log.location_id = nil
		assert_not @log.valid?
	end

	test 'title too long' do
		@log.title = 'a' * 26
		assert_not @log.valid?
	end

	test "title not present" do
		@log.title = '   '
		assert_not @log.valid?
	end

	test 'content too long' do
		@log.content = 'a' * 1001
		assert_not @log.valid?
	end

	test 'content not present' do
		@log.content = '  '
		assert_not @log.valid?
	end

	test 'most recent first in order' do
		assert_equal logs(:most_recent), Log.first
	end


end
