module API
  module V1
    class LikesController < ApplicationController
      layout false

      def create
        if current_user
          photo = Photo.find(params[:photo_id])
          like = photo.likes.create(user_id: current_user.id)
          if like.save
            render json: photo , status: 201 , location: photo
          else
            render json: { message: 'Something went wrong' }
          end
        else
          render json: { message: 'To add a like to the site login (/auth/:provider), please' }
        end
      end

    end
  end
end