class Franchise < ActiveRecord::Base
  	
  	validates :franchise_name, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    #validates :password, presence: true
    
    has_secure_password
end
