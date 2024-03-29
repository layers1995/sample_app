class User < ApplicationRecord
	attr_accessor :remember_token

	before_save { email.downcase! }

	validates(:name, presence: true, length: { maximum: 50 })
	
	EmailRegex = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
	validates(:email, presence: true, length: { maximum: 255 }, 
		format: { with: EmailRegex },
		uniqueness: { case_sensitive: false })

	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		if remember_digest.nil?
			return false
		else
			BCrypt::Password.new(remember_digest).is_password?(remember_token)
		end
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end
end
