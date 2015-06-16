class RemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :customer_types, :user_type_id
  	remove_column :customers, :daycare_user_type
  end
end
