class Customer < ActiveRecord::Base
    has_one :customer_type
    has_and_belongs_to_many :daycare_departments, join_table: :customers_daycare_departments
    
    validates :customer_name, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true
    validates :customer_type_id, presence: true

    has_secure_password
end
