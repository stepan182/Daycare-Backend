class CustomersPrivileges < ActiveRecord::Migration
  def change
    create_table :customers_privileges do |t|
      t.belongs_to :customer
      t.belongs_to :privilege
    end
    
    add_index :customers_privileges, :customer_id
    add_index :customers_privileges, :privilege_id
  end
end
