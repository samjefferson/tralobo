class Location < ActiveRecord::Base
	has_many :logs

	CITY_REGEX = /\A[A-Za-z\s]+\z/
	validates :city, presence: true, length: { maximum: 25 }, format: { with: CITY_REGEX }, uniqueness: { case_sensitive: false }
	LAT_LONG_REGEX = /\A-?\d+.\d+,-?\d+.\d+\z/
	validates :coordinate, format: { with: LAT_LONG_REGEX }
	validates :continent, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0,
					 less_than: 8 }
end
