class AddCustomerTypeRefToUserType < ActiveRecord::Migration
  def change
  	add_belongs_to(:user_types, :customer_type)
  end
end
