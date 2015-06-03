class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :subtask
      t.references :task, index: true, foreign_key: true
      t.timestamps
    end
  end
end
