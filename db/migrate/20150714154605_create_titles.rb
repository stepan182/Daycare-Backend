class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :title
      t.references :customer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
