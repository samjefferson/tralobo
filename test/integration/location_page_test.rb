require 'test_helper'

class LocationPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
  	@location = locations(:test)
  end

	test 'displayed information' do 
		get location_path(@location)
		assert_template 'locations/show'
		assert_select 'title', full_title(@location.city)
		assert_match @location.logs.count.to_s, response.body
		@location.logs.paginate(page: 1).each do |log|
      assert_match log.title, response.body
    end

	end
end
