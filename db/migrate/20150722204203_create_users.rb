class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :email
      t.text :address
      t.string :country
      t.timestamps
    end

    add_reference :users, :customer, index: true
  end
end
