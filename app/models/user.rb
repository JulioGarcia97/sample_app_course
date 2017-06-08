class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token
	before_save :downcase_email
  before_create :create_activation_digest

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	#/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX},
										uniqueness: {case_sensitive: false}

	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_secure_password

  has_many :microposts, dependent: :destroy

	# Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def new_token
    SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = self.new_token
  	update_attribute(:remember_digest, self.digest(remember_token))
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = self.new_token
    self.activation_digest = self.digest(activation_token)
  end
end
