class Privilege < ActiveRecord::Base
  has_and_belongs_to_many :customers, join_table: :customers_privileges
end
