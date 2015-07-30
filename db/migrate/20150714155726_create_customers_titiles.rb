class CreateCustomersTitiles < ActiveRecord::Migration
  def change
    create_table :customers_titiles do |t|
    	t.belongs_to :customer
      	t.belongs_to :title
    end

    add_index :customers_titiles, :customer_id
    add_index :customers_titiles, :title_id
  end
end
