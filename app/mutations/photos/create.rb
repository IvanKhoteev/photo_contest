module Photo
  class Create < Mutations::Command

    required do
      model  :user
      string :photo_name
      file   :photo
    end

    def execute
      photo = current_user.photos.build(params)
      photo.likes_count = 0
      photo.save
      photo
    end

    

  end
end
