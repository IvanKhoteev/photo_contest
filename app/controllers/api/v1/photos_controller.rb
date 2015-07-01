module API
  module V1

    class PhotosController < ApplicationController
      layout false

      def create
        if current_user
          photo = Photo.new(name: params[:name], photo: params[:photo], user_id: current_user.id)
          if photo.save
            render json: photo , status: 201 , location: photo
          else
            render json: { message: 'Something went wrong' }
          end
        else
          render json: { message: 'To add a photo to the site login (/auth/:provider), please' }
        end
      end

      def index
        @photos = Photo.approved
        @photos = @photos.searced(params[:search]) if params[:search].present?
        @photos = @photos.recent if params.include?(:recent)
        @photos = @photos.popular if params.include?(:popular)
        render status: 200
      end
     
      def show
        @photo = Photo.approved.find(params[:id])
        render status: 200
      end

      def show_comments
        @photos = Photo.approved.find(params[:photo_id])
      end

    end
  end
end