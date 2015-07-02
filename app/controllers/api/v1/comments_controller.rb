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
          comment = photo.comments.create(photo_id: params[:photo_id], body: params[:body], user_id: current_user.id)
          comment.parent_comment_id = params[:parent_comment_id] if params[:parent_comment_id].present?
          comment.save
          if comment.save
            render json: { message: 'The comment has been successfully saved' }
          else
            render json: { message: 'Something went wrong' }
          end
        else
          render json: { message: 'To add a comment to the site login (/auth/:provider), please' } , status: 401
        end
      end

    end
  end
end