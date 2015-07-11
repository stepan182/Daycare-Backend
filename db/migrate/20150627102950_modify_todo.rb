class ModifyTodo < ActiveRecord::Migration
  def change
  	remove_column :todos, :user_type_id
  	remove_column :todos, :daycare_department_id
  	remove_column :todos, :delegatable
  end
end
