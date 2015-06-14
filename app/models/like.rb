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
# Foreign Keys
#
#  fk_rails_1e09b5dabf  (user_id => users.id)
#  fk_rails_42d246f2ea  (photo_id => photos.id)
#

class Like < ActiveRecord::Base
  belongs_to :photo, counter_cache: :likes_count
  belongs_to :user
  
  validates :photo_id, uniqueness: {scope: :user_id}

end
