class Task < ActiveRecord::Base
    belongs_to :todo
    has_many :subtasks, dependent: :destroy
    has_many :task_complainces, dependent: :destroy
    
end
