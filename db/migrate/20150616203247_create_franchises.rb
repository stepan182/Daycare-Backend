class CreateFranchises < ActiveRecord::Migration
  def change
    create_table :franchises do |t|
      t.string :franchise_name
      t.string :username
      t.string :password_digest
      t.string :email
      t.text :address
      t.string :country
      t.timestamps
    end
  end
end
