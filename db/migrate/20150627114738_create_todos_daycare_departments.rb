class CreateTodosDaycareDepartments < ActiveRecord::Migration
  def change
    create_table :todos_daycare_departments do |t|
      t.belongs_to :todo
      t.belongs_to :daycare_department
    end
    
    add_index :todos_daycare_departments, :todo_id
    add_index :todos_daycare_departments, :daycare_department_id

  end
end
