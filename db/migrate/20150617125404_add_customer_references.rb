class AddCustomerReferences < ActiveRecord::Migration
  def change
  	add_reference :customer_types, :customer, index: true
  	add_reference :user_types, :customer, index: true
  	add_reference :franchises, :customer, index: true
  	add_reference :partners, :customer, index: true
  end
end
