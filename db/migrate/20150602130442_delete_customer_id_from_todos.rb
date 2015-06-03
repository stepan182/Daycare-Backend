class DeleteCustomerIdFromTodos < ActiveRecord::Migration
  def change
    remove_column :todos, :customer_id
  end
end
