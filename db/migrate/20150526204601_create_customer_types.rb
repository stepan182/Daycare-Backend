class CreateCustomerTypes < ActiveRecord::Migration
  def change
    create_table :customer_types do |t|
      t.string :type_name
    end
  end
end
