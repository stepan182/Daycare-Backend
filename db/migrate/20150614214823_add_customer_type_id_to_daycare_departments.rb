class AddCustomerTypeIdToDaycareDepartments < ActiveRecord::Migration
  def change
  	add_reference :daycare_departments, :customer_type, index: true
  end
end
