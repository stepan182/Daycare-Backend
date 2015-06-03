class Task < ActiveRecord::Base
    belongs_to :todo
    has_many :subtasks, dependent: :destroy
    
end
