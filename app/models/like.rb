class Like < ActiveRecord::Base
  belongs_to :photo_gallery, counter_cache: :likes_count
  belongs_to :user
  
  validates :photo_gallery_id, uniqueness: {scope: :user_id}

end
