class User < ActiveRecord::Base
	belongs_to :customer
	
	validates :name, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true

    has_secure_password
end
