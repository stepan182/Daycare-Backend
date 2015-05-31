class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :allergy_name
      t.text :description
      t.string :icon
      t.timestamps
    end
  end
end
