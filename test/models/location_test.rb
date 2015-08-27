require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  
  def setup
  	@location = Location.new(continent: 0, state: 0, city: "London", coordinate: '12.12,12.12')
  end

  test 'valid details' do
  	assert @location.valid?
  end

  test 'city name is too long' do
  	@location.city = 'a' * 26
  	assert_not @location.valid?
  end

  test 'city name must not contain non-letters or non-spaces' do
  	invalid_cities = %w[ lond0n lon.d lon-_ lon1 9k]
  	invalid_cities.each do |invalid_city|
  		@location.city = invalid_city
  		assert_not @location.valid?, "#{invalid_city.inspect} should be invalid"
  	end
  end

  test "integer above or below range should be invalid for continent" do
  	invalid_conts = [-1, 8]
  	invalid_conts.each do |invalid_cont|
  		@location.continent = invalid_cont
  		assert_not @location.valid?, "#{invalid_cont.inspect} should be invalid"
  	end
  end

  test "valid latlong" do
  	@location.coordinate = "12.46,45.21"
  	assert @location.valid?
  end

  test "invalid latlong" do
  	invalid_coordinates = %w[a34,321 234 1%,3 ad 12,12]
  	invalid_coordinates.each do |invalid_coordinate|
  		@location.coordinate = invalid_coordinate
  		assert_not @location.valid?, "#{invalid_coordinate.inspect} should be invalid"
  	end
  end


end
