# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  photo_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_likes_on_photo_id              (photo_id)
#  index_likes_on_photo_id_and_user_id  (photo_id,user_id) UNIQUE
#  index_likes_on_user_id               (user_id)
#

class Like < ActiveRecord::Base
  belongs_to :photo, counter_cache: :likes_count
  belongs_to :user
end
