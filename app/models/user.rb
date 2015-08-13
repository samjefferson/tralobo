class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :username, presence: true, length: {maximum: 16}, uniqueness: { case_sensitive: false }
	validates :email, presence: true, length: {maximum: 255}, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	PASS_REGEX = /\A(?=.*\d)(?=.*[a-zA-Z])[A-Za-z\d]+\z/
	validates :password, presence: true, length: { within: 6..16}, format: { with: PASS_REGEX }
end
