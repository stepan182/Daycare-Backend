class AddCustomerTypeRefToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :customer_type, index: true
  end
end
