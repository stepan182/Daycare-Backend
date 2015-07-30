class DaycareDepartment < ActiveRecord::Base
  has_and_belongs_to_many :customers, join_table: :customers_daycare_departments
  has_and_belongs_to_many :todos, join_table: :todos_daycare_departments
  has_and_belongs_to_many :titles, join_table: :titles_daycare_departments

  default_scope -> { order(department_name: :asc) }
end
