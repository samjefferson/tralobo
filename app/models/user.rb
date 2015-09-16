class User < ActiveRecord::Base
	has_many :logs, dependent: :destroy
  has_many :comments
  attr_accessor :remember_token

	before_save { self.email = email.downcase }
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :username, presence: true, length: {maximum: 16}, uniqueness: { case_sensitive: false }
	validates :email, presence: true, length: {maximum: 255}, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password
	PASS_REGEX = /\A(?=.*\d)(?=.*[a-zA-Z])[A-Za-z\d]+\z/
	validates :password, presence: true, length: { within: 6..16}, format: { with: PASS_REGEX }

	scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first}

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  acts_as_voter

end
