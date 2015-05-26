class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :username
      t.string :email
      t.string :country
      t.string :password_digest
      t.timestamps
    end
  end
end
