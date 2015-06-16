class AddCustomerRefToUserType < ActiveRecord::Migration
  def change
  	add_reference :user_types, :customer, index: true
  end
end
