module API
  module V1
    class UsersController < ApplicationController
      layout false
      
      def index
        @users = User.all
        @users = @users.where('users.name ILIKE ?', "%#{params[:search]}%") if params[:search].present?
        @users = @users.order(created_at: :desc).limit(5) if params.include?(:recent)
        render status: 200
      end
      
      def show
        @user = User.find(params[:id])
        render status: 200
      end

      def show_photos
        @user = User.find(params[:user_id])
        render status: 200
      end

      def show_comments
        @user = User.find(params[:user_id])
        render status: 200
      end

    end
  end
end