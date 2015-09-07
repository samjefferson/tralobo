require 'test_helper'

class LocationsEditTest < ActionDispatch::IntegrationTest
  def setup
  	@location = locations(:test)
  end

  test 'unsuccessful edit' do 
  	get edit_location_path(@location)
  	assert_template 'locations/edit'
  	patch location_path(@location), location: {
  															continent: 0,
  															state: 0,
  															city: '345ci',
  															coordinate: 'hello',
  															} 
  	assert_template 'locations/edit'
  end

  test 'successful edit' do 
  	get edit_location_path(@location)
  	assert_template 'locations/edit'
  	city = 'Example city two'
  	patch location_path(@location), location: {
  																continent: 0,
  																state: 0,
  																city: city,
  																coordinate: '23.23,23.23'
  																}
  	assert_not flash.empty?
  	assert_redirected_to @location
  	@location.reload
  	assert_equal city, @location.city
  end

end
