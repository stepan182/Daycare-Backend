class Todo < ActiveRecord::Base
    has_and_belongs_to_many :customers, join_table: :customers_todos
    has_many :tasks, dependent: :destroy
    
    default_scope -> { order(created_at: :desc) }
    validates :subject, presence: true
    validates :complete_by, presence: true

end
