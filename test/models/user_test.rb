require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: 'Julio', email: 'julio@shipkraken.com', password: 'shipkraken', password_confirmation: 'shipkraken')
  end

  test 'check user is valid' do
  	assert @user.valid?
  end

  test 'name should be present and not too long' do
  	@user.name = 'a' * 51
  	assert_not @user.valid?
  end

  test 'email should be present and no too long and with valid email @' do
  	@user.email = 'a' * 244 + '@shipkraken.com'
   	assert_not @user.valid?
  end

  test 'Valid Email Addresses' do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

  	valid_addresses.each do |isvalid|
  		@user.email = isvalid
  		assert @user.valid?, "#{isvalid.inspect} Should be valid"
  	end
  end

  test 'Invalid Email Addresses' do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

  	invalid_addresses.each do |invalid|
  		@user.email = invalid
  		assert_not @user.valid?, "#{invalid.inspect} should be invalid"
  	end
  end

  test 'Email is unique?' do
  	duplicate_email = @user.dup
  	duplicate_email.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_email.valid?
  end

  test 'Email address should save in lowercase' do
    email_address = "Foo@ExAMPle.CoM"
    @user.email = email_address
    @user.save
    assert_equal email_address.downcase, @user.reload.email
  end

  test 'pasword can not be blank' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
