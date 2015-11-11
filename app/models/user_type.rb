class UserType < ActiveRecord::Base
  belongs_to :customer_type
  belongs_to :customer
  has_and_belongs_to_many :todos, join_table: :todos_user_types
  has_and_belongs_to_many :titles, join_table: :titles_user_types

  validates :user_type_name, presence: true
end
