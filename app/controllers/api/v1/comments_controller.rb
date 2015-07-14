# ...
module API
  # ...
  module V1
    # ...
    class CommentsController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def create
        photo = Photo.find(params[:photo_id])
        outcome = Comments::Create.run(photo: photo, user: current_user, body: params[:body],
                                       parent_comment_id: params[:parent_comment_id])
        if outcome.success?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end
    end
  end
end
