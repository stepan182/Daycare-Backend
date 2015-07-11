class AddRepeatToTodo < ActiveRecord::Migration
  def change
  	add_column :todos, :repeat, :string
  end
end
