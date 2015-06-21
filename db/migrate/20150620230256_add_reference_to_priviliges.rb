class AddReferenceToPriviliges < ActiveRecord::Migration
  def change
  	add_reference :privileges, :user_type
  end
end
