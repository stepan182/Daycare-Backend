class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :partner_name
      t.string :username
      t.string :password_digest
      t.string :email
      t.text :address
      t.string :country
      t.timestamps
    end
  end
end
