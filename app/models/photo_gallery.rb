class PhotoGallery < ActiveRecord::Base
  belongs_to :user
  has_many   :comments
  has_many   :likes
  
#  default_scope -> { order(created_at: :desc) }

  mount_uploader :photography, PhotographyUploader
  validates :user_id, presence: true
  validates :photo_name, presence: true, length: { maximum: 100, minimum: 6 }
  validates :photography, presence: true
end
