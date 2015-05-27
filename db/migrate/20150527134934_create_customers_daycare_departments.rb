class CreateCustomersDaycareDepartments < ActiveRecord::Migration
  def change
    create_table :customers_daycare_departments do |t|
      t.belongs_to :customer
      t.belongs_to :daycare_department
    end
    
    add_index :customers_daycare_departments, :customer_id
    add_index :customers_daycare_departments, :daycare_department_id

  end
end
