class AddReferencesToCustomerType < ActiveRecord::Migration
  def change
  	add_reference :daycare_departments, :franchise, index: true
  end
end
