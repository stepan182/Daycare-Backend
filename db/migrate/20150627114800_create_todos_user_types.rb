class CreateTodosUserTypes < ActiveRecord::Migration
  def change
    create_table :todos_user_types do |t|
      t.belongs_to :todo
      t.belongs_to :user_type
    end
    
    add_index :todos_user_types, :todo_id
    add_index :todos_user_types, :user_type_id

  end
end
