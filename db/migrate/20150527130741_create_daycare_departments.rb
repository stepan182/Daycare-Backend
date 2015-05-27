class CreateDaycareDepartments < ActiveRecord::Migration
  def change
    create_table :daycare_departments do |t|
      t.string :department_name
      t.timestamps
    end
  end
end
