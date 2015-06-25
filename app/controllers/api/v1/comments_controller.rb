module Api
  module V1

    class CommentsController < ApplicationController

      def index
        @comments = Comment.where(user_id: params[:user_id]) if params[:user_id].present?
        @comments = Comment.where(photo_id: params[:photo_id]) if params[:photo_id].present?
        render json: @comments
      end
     
    end
  end
end