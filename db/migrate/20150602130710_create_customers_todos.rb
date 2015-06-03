class CreateCustomersTodos < ActiveRecord::Migration
  def change
    create_table :customers_todos do |t|
      t.belongs_to :customer
      t.belongs_to :todo
    end
    
    add_index :customers_todos, :customer_id
    add_index :customers_todos, :todo_id
  end
end
