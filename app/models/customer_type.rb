class CustomerType < ActiveRecord::Base
  has_many :customers
  has_many :user_types
  
  validates :type_name, presence: true
end
