require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(username: "example123", email: "admin@example.com",
  		password: "jeffo50", password_confirmation: "jeffo50")
  end


  test "should be valid" do 
  	assert @user.valid?
  end

  test "username presence" do
  	@user.username = "       "
  	assert_not @user.valid?
  end

  test "uniqueness" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	duplicate_user.username = @user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email presence" do
  	@user.email = '     '
  	assert_not @user.valid?
  end

  test 'username too long' do
  	@user.username = 'a' *17
  	assert_not @user.valid?
  end

  test 'email too long' do
  	@user.email = 'a' *244 + '@example.com'
  	assert_not @user.valid?
  end

  test "email valid addresses" do
    valid_addresses = %w[user@example.com USER@sam.COM S_am-Je@exa.mpl.org
                         sam.jef@examp.ex sam+exam@ple.uk]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email invalid addresses" do
    invalid_addresses = %w[user@example,com sam_at_sam.org sam.test@example.
                           jef@sam_sam.com exam@sam+sam.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'password presence' do
  	@user.password = @user.password_confirmation = '      '
  	assert_not @user.valid?
  end

  test 'password max length' do
  	@user.password = @user.password_confirmation = 'a' * 16 +'1'
  	assert_not @user.valid?
  end

  test 'password min length' do
  	@user.password = @user.password_confirmation = 'aaaa1'
  	assert_not @user.valid?
  end

  test 'password must contain a letter and number' do
  	invalid_passwords = %w[samuel 123456]
  	invalid_passwords.each do |invalid_password|
  		@user.password = @user.password_confirmation = invalid_password
  		assert_not @user.valid?
  	end
  end

  test 'authenticate? false for nil token' do
    assert_not @user.authenticated?('')
  end

end
