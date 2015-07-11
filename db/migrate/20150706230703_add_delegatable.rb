class AddDelegatable < ActiveRecord::Migration
  def change
  	add_column :todos, :delegatable, :boolean
  	add_column :subtasks, :delegatable, :boolean
  end
end
