class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :subject
      t.datetime :complete_by
      t.references :customer, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
