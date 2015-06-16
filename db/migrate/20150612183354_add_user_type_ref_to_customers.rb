class AddUserTypeRefToCustomers < ActiveRecord::Migration
  def change
  	add_reference :customers, :user_type, index: true
  end
end
