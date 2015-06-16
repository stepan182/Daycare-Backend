class CustomerType < ActiveRecord::Base
  belongs_to :customer
  has_many :user_types
  
  validates :type_name, presence: true
end
