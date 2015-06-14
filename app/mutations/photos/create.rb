module Photos
  
  class Create < Mutations::Command
    
    required do
      string  :photo_name
    end

    def execute
      photo = Photo.create(inputs)
      photo.likes_count = 0
      photo.save
      photo
    end

    outcome = Create.run!(params)

    if outcome.success?
      @photo = outcome.result
    else
      render json: outcome.errors
      #render plain: params
    end  
    
  end
end