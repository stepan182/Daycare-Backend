class AddCustomerRefToCustomerType < ActiveRecord::Migration
  def change
  	add_reference :customer_types, :customer, index: true
  end
end
