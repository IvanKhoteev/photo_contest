# ...
module Likes
  # ...
  class Create < Mutations::Command
    required do
      model :user
      model :photo
    end

    def execute
      photo.likes.create(user: user)
    end

    def validate
      add_error(:uniqieness, :users_like_already_exist, 'You are already liked this photo!') if Like.where(user_id: user.id, photo_id: photo.id).any?
    end
  end
end
