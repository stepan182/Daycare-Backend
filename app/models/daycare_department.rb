class DaycareDepartment < ActiveRecord::Base
  has_and_belongs_to_many :customers, join_table: :customers_daycare_departments
end
