class CreateTaskComplainces < ActiveRecord::Migration
  def change
    create_table :task_complainces do |t|
      t.belongs_to :task
      t.timestamps
    end

    add_index :task_complainces, :task_id

  end
end
