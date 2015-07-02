module API
  module V1
    class LikesController < ApplicationController
      layout false

      def create
        if current_user
          photo = Photo.find(params[:photo_id])
          outcome = Likes::Create.run(photo: photo, user: current_user)
          if outcome.success?
            like = outcome.result
            render nothing: true, status: 201
          else
            render json: outcome.errors.symbolic, status: 422
          end
        else
          render json: { message: 'To add a like to the site login (/auth/:provider), please' }, status: 401
        end
      end

    end
  end
end