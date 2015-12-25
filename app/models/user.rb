class User < ActiveRecord::Base
	has_many :logs, dependent: :destroy
  has_many :comments
  attr_accessor :remember_token, :reset_token

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

 def authenticated?(attribute, token)
  digest = self.send("#{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token)
end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  #password reset expiration
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  acts_as_voter

end
