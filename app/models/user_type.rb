class UserType < ActiveRecord::Base
	belongs_to :customer_type
	belongs_to :customer
	has_and_belongs_to_many :todos, join_table: :user_types_daycare_departments

	validates :user_type_name, presence: true
end
