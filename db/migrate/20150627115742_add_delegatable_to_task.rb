class AddDelegatableToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :delegatable, :boolean
  end
end
