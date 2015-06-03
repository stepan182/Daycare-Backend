class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task
      t.references :todo, index: true, foreign_key: true
      t.timestamps
    end
  end
end
