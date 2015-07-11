class AddDelegateToTodos < ActiveRecord::Migration
  def change
  	#add_reference :todos, :daycare_department
  	add_column :todos, :delegatable, :boolean
  end
end
