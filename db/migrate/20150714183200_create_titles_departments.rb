class CreateTitlesDepartments < ActiveRecord::Migration
  def change
    create_table :titles_daycare_departments do |t|
    	t.belongs_to :title
      	t.belongs_to :daycare_department
    end

    add_index :titles_daycare_departments, :title_id
    add_index :titles_daycare_departments, :daycare_department_id
  end
end
