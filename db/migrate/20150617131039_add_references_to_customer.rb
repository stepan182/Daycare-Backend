class AddReferencesToCustomer < ActiveRecord::Migration
  def change
  	add_reference :customers, :franchise, index: true
  	add_reference :customers, :partner, index: true

  	remove_reference :daycare_departments, :customer_type, index: true
  end
end
