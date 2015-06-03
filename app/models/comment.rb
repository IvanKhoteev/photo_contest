class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo_gallery
end
