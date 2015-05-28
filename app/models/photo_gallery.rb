class PhotoGallery < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  mount_uploader :photography, PhotographyUploader
  validates :user_id, presence: true
  validates :photo_name, presence: true, length: { maximum: 255, minimum: 6 }
end
