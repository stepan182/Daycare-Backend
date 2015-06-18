class AddReferencesToUserType < ActiveRecord::Migration
  def change
  	add_reference :user_types, :franchise, index: true
  	add_reference :user_types, :partner, index: true
  end
end
