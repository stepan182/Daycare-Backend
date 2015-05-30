class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.boolean :to_do
      t.boolean :attendance
      t.boolean :message
      t.boolean :allergy
      t.boolean :medication
      t.boolean :notice_board
      t.boolean :calendar
      t.boolean :intolerance
      
    end
  end
end
