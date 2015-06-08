class PhotoGallery < ActiveRecord::Base
	include AASM

  self.per_page = 10

  belongs_to :user
  has_many   :comments
  has_many   :likes
  
  mount_uploader :photography, PhotographyUploader
  
  validates :user_id, presence: true
  validates :photo_name, presence: true, length: { maximum: 100, minimum: 6 }
  validates :photography, presence: true

  aasm do # default column: aasm_state
    state :moderated, :initial => true
    state :approved
    state :banned

    event :approve do
      transitions :from => :moderated, :to => :approved
    end

    event :ban do
      transitions :from => :moderated, :to => :banned
      transitions :from => :approved, :to => :banned
    end

    event :allow do
      transitions :from => :banned, :to => :approved
    end

  end
  
end
