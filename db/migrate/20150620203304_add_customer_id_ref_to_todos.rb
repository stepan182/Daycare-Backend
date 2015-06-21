class AddCustomerIdRefToTodos < ActiveRecord::Migration
  def change
  	add_reference :todos, :user_type
  end
end
