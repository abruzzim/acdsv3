class User < ActiveRecord::Base
	# Callbacks
	#
	# Store all email addresses in lowercase format.
	# This will prevent the case-sensitive database index 
	# from treating the same string, which differs only in case, 
	# as different strings.
	#
	before_save do
		puts "%USER-I-BEFORE_SAVE, running callback."
		# self.email = email.downcase
		email.downcase!

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
end
