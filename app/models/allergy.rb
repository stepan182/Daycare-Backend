class Allergy < ActiveRecord::Base
  validates :allergy_name, presence: true
  validates :description, presence: true
  mount_uploader :icon, PictureUploader
  validate :picture_size


  private

  # Validates the size of an uploaded picture.
  def picture_size
    if icon.size > 5.megabytes
      errors.add(:icon, "should be less than 5MB")
    end
  end

end
