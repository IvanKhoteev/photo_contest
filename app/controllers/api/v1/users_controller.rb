module Api
  module V1

    class UsersController < ApplicationController

      def index
        @users = User.all
        render json: @users
      end
     
      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def search
        @users = User.where( 'name ILIKE ?', "%#{params[:sub_name]}%")
        render json: @users
      end

      def recent
        @users = User.order(created_at: :desc).limit(5)
        render json: @users
      end

    end
  end
end