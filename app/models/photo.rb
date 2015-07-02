# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  name        :string
#  photo       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default(0)
#  aasm_state  :string
#
# Indexes
#
#  index_photos_on_user_id                 (user_id)
#  index_photos_on_user_id_and_created_at  (user_id,created_at)
#

class Photo < ActiveRecord::Base
	include AASM

  self.per_page = 10

  belongs_to :user
  has_many   :comments
  has_many   :likes
  default_scope     -> { order(created_at: :desc) }
  scope :filtered_by_user_sub_name, -> (sub_name) { joins(:user).where( 'users.name ILIKE ?', "%#{sub_name}%") }
  scope :searched,  -> (name) { where('photos.name ILIKE ?', "%#{name}%") }
  scope :from_user, -> (user_id) { where(user_id: user_id) }
  scope :recent,    -> { reorder(created_at: :desc).limit(5) }
  scope :popular,   -> { reorder(likes_count: :desc).limit(5) }

  mount_uploader :photo, PhotographyUploader
  
  aasm do # default column: aasm_state
    state :moderated, initial: true
    state :approved
    state :banned

    event :approve do
      transitions :from => [:moderated, :banned], :to => :approved
    end

    event :ban do
      transitions :from => [:moderated, :approved], :to => :banned
    end

  end
  
end
