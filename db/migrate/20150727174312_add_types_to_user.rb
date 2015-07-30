class AddTypesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :is_manager, :string
  	add_column :users, :is_worker, :string
  	add_column :users, :is_parent, :string
  end
end
