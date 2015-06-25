module Api
  module V1

    class PhotosController < ApplicationController

      def index
        @photos = Photo.approved
        @photos = @photos.reorder(params[:sorting]) if params[:sorting].present?
        @photos = @photos.filtered_by_user_sub_name(params[:search_by_users_name]) if params[:search_by_users_name].present?
        render json: @photos
      end
     
      def show
        @photo = Photo.find(params[:id])
        render json: @photo
      end

      def show_collection
        @photos = Photo.approved.where(user_id: params[:user_id])
        render json: @photos
      end

      def search
        @photos = Photo.where( 'name ILIKE ?', "%#{params[:sub_name]}%")
        render json: @photos
      end

      def recent
        @photos = Photo.reorder(created_at: :desc).limit(5)
        render json: @photos
      end

      def popular
        @photos = Photo.reorder(likes_count: :desc).limit(3)
        render json: @photos        
      end

    end
  end
end