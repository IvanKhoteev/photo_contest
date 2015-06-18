module Photos
  class Create < Mutations::Command

    required do
      model  :user
      string :name, min_length: 5
      file   :photo
    end

    def execute
      user.photos.create(name: :name, photo: :photo)
    end
  
  end
end
