# ...
module API
  # ...
  module V1
    # ...
    class LikesController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def create
        photo = Photo.find(params[:photo_id])
        outcome = Likes::Create.run(photo: photo, user: current_user)
        if outcome.success?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end
    end
  end
end
