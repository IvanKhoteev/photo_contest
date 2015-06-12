class Photo < ActiveRecord::Base
	include AASM

  self.per_page = 10

  belongs_to :user
  has_many   :comments
  has_many   :likes
  
  mount_uploader :photo, PhotographyUploader
  
  validates :user_id, presence: true
  validates :photo_name, presence: true, length: { maximum: 100, minimum: 6 }
  validates :photo, presence: true

  aasm do # default column: aasm_state
    state :moderated, :initial => true
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
