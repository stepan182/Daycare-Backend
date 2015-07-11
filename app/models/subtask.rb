class Subtask < ActiveRecord::Base
    belongs_to :task
    has_many :subtask_complainces, dependent: :destroy
    
end
