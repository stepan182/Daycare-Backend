class Title < ActiveRecord::Base
  has_and_belongs_to_many :customers, join_table: :customers_titiles
  has_and_belongs_to_many :daycare_departments, join_table: :titles_daycare_departments
  has_and_belongs_to_many :user_types, join_table: :titles_user_types
end
