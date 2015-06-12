class Like < ActiveRecord::Base
  belongs_to :photo, counter_cache: :likes_count
  belongs_to :user
  
  validates :photo_id, uniqueness: {scope: :user_id}

end
