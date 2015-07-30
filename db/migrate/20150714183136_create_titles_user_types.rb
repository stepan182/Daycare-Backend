class CreateTitlesUserTypes < ActiveRecord::Migration
  def change
    create_table :titles_user_types do |t|
    	t.belongs_to :title
      	t.belongs_to :user_type
    end

    add_index :titles_user_types, :title_id
    add_index :titles_user_types, :user_type_id
  end
end
