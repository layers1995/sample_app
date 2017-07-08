class User < ApplicationRecord

	before_save { email.downcase! }

	validates(:name, presence: true, length: { maximum: 50 })
	
	EmailRegex = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i
	validates(:email, presence: true, length: { maximum: 255 }, 
		format: { with: EmailRegex },
		uniqueness: { case_sensitive: false })

	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password
end
