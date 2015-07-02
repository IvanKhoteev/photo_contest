module API
  module V1
    class CommentsController < ApplicationController
      layout false

      def index
        @comments = Comment.all
        @comments = @comments.where(user_id: params[:user_id]) if params[:user_id].present?
        @comments = @comments.where(photo_id: params[:photo_id]) if params[:photo_id].present?
      end

      def create
        if current_user
          photo = Photo.find(params[:photo_id])
          body = params[:body].present? ? params[:body] : nil
          outcome = Comments::Create.run(photo: photo, user: current_user, body: body, parent_comment_id: params[:parent_comment_id])
          if outcome.success?
            comment = outcome.result
            render nothing: true, status: 201
          else
            render json: outcome.errors.symbolic, status: 422
          end
        else
          render json: { message: 'To add a comment to the site login (/auth/:provider), please' } , status: 401
        end
      end

    end
  end
end