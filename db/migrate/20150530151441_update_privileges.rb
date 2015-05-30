class UpdatePrivileges < ActiveRecord::Migration
  def change
    remove_column :privileges, :to_do
    remove_column :privileges, :attendance
    remove_column :privileges, :message
    remove_column :privileges, :allergy
    remove_column :privileges, :medication
    remove_column :privileges, :notice_board
    remove_column :privileges, :calendar
    remove_column :privileges, :intolerance
    
    add_column :privileges, :privilege_name, :string
  end
end
