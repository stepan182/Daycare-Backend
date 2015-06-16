class UserType < ActiveRecord::Base
	belongs_to :customer_type
	belongs_to :customer

	validates :user_type_name, presence: true
end
