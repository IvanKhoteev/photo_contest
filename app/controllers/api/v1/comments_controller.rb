# ...
module API
  # ...
  module V1
    # ...
    class CommentsController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def index
        comments = Comment.all
        comments = comments.where(user_id: params[:user_id]) if params[:user_id].present?
        comments = comments.where(photo_id: params[:photo_id], parent_comment_id: nil) if params[:photo_id].present?
        render json: comments, user_id: params[:user_id], status: 200
      end

      def create
        photo = Photo.find(params[:photo_id])
        body = params[:body].present? ? params[:body] : nil
        outcome = Comments::Create.run(photo: photo, user: current_user, body: body, parent_comment_id: params[:parent_comment_id])
        if outcome.success?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end
    end
  end
end
