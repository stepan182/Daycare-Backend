class DeleteIndexFromTodos < ActiveRecord::Migration
  def change
    remove_index :todos, :customer_id
  end
end
