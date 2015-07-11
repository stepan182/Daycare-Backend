class CreateSubtaskComplainces < ActiveRecord::Migration
  def change
    create_table :subtask_complainces do |t|
	  t.belongs_to :subtask
      t.timestamps
    end

    add_index :subtask_complainces, :subtask_id

  end
end
