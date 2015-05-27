class CustomerType < ActiveRecord::Base
  belongs_to :customer
  
  validates :type_name, presence: true
end
