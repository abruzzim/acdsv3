class User < ActiveRecord::Base

	# Create and accessible attribute.
	attr_accessor :remember_token

	# Callbacks
	#
	# Store all email addresses in lowercase format.
	# This will prevent the case-sensitive database index 
	# from treating the same string, which differs only in case, 
	# as different strings.
	#
	before_save do
		puts "%USER-I-BEFORE_SAVE, running callback."
		self.email = email.downcase
		#email.downcase!

	end

	# Validations
	#
	# This method is a shortcut to all default validators and any custom validator classes ending in 'Validator'. 
	# Note that Rails default validators can be overridden inside specific classes by creating custom validator 
	# classes in their place such as PresenceValidator.
	#
	# Examples:
	#
	# validates :terms, acceptance: true
	# validates :password, confirmation: true
	# validates :username, exclusion: { in: %w(admin superuser) }
	# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	# validates :age, inclusion: { in: 0..9 }
	# validates :first_name, length: { maximum: 30 }
	# validates :age, numericality: true
	# validates :username, presence: true
	# validates :username, uniqueness: true
	#
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, presence: true)
	validates(:name, length: { maximum: 50, too_long: "Maximum user name size is %{count} characters." })
	validates(:email, presence: true)
	validates(:email, length: { maximum: 254, too_long: "Maximum email address size is %{count} characters." })
	validates(:email, format: { with: VALID_EMAIL_REGEX })
	validates(:email, uniqueness: { case_sensitive: false })

	# Secure Password
	#
	# has_secure_password(options = {}) ⇒ Object
	# Ref: http://www.rubydoc.info/gems/has_secure_password/0.1.0/ActiveRecord/SecurePassword/ClassMethods#has_secure_password-instance_method
	has_secure_password
	validates(:password, length: { minimum: 6 })

	# Returns the hash digest of the given string.
	#
  def User.digest(string)
  	puts "%USER-I-TRACE, User.digest called."
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random 22 character Base64 token.
  #
  def User.new_token
  	puts "%USER-I-TRACE, User.new_token called."
  	SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in a persistent session.
  #
  def remember
  	puts "%USER-I-TRACE, remember called."
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Forgets a user's persistent session.
	#
	def forget
  	puts "%USER-I-TRACE, forget called."
		update_attribute(:remember_digest, nil)
	end

	# Returns true if the given token matches the digest.
	#
	def authenticated?(remember_token)
  	puts "%USER-I-TRACE, authenticated? called."
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

end
