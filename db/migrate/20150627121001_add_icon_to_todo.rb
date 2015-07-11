class AddIconToTodo < ActiveRecord::Migration
  def change
  	add_column :todos, :icon, :string
  end
end
