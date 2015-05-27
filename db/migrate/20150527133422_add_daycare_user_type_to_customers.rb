class AddDaycareUserTypeToCustomers < ActiveRecord::Migration
  
  def change
    add_column :customers, :daycare_user_type, :string
    add_index :customers, :username, unique: true
  end
  
  
end
