class Todo < ActiveRecord::Base
    has_and_belongs_to_many :customers, join_table: :customers_todos
    has_many :tasks, dependent: :destroy
    has_and_belongs_to_many :daycare_departments, join_table: :todos_daycare_departments
    has_and_belongs_to_many :user_types, join_table: :todos_user_types
    
    default_scope -> { order(created_at: :desc) }
    validates :subject, presence: true
    #validates :complete_by, presence: true

    mount_uploader :icon, PictureUploader
    validate  :picture_size

    private

    # Validates the size of an uploaded picture.
    def picture_size
      if icon.size > 5.megabytes
        errors.add(:icon, "should be less than 5MB")
      end
    end

end
