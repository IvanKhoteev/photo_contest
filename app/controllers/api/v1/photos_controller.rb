# ...
module API
  # ...
  module V1
    # ...
    class PhotosController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def create
        outcome = Photos::Create.run(name: params[:name],
                                     photo: params[:photo], user: current_user)
        if outcome.success?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end

      def index
        photos = Photo.approved
        photos = photos.searched(params[:search]) if params[:search].present?
        photos = photos.from_user(params[:user_id]) if params[:user_id].present?
        photos = photos.recent if params.include?(:recent)
        photos = photos.popular if params.include?(:popular)
        render json: photos, status: 200
      end

      def show
        photo = Photo.approved.find(params[:id])
        render json: photo, status: 200
      end

    end
  end
end
