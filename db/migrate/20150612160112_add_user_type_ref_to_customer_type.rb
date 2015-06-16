class AddUserTypeRefToCustomerType < ActiveRecord::Migration
  def change
  	add_reference :customer_types, :user_type, index: true
  end
end
