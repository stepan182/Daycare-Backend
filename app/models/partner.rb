class Partner < ActiveRecord::Base
  has_many :customers

  validates :partner_name, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  #validates :password, presence: true

  has_secure_password

  mount_uploader :logo, PictureUploader
  validate :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if logo.size > 5.megabytes
      errors.add(:logo, "should be less than 5MB")
    end
  end

end
