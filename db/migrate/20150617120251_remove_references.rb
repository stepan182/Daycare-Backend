class RemoveReferences < ActiveRecord::Migration
  def change
  	remove_reference :user_types, :customer
  	remove_reference :customer_types, :customer
  end
end
