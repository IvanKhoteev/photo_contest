module API
  module V1
    class UsersController < ApplicationController
      layout false
      def index
        @users = User.all
        @users = @users.where('users.name ILIKE ?', "%#{params[:search]}%") if params[:search].present?
        @users = @users.order(created_at: :desc).limit(5) if params.include?(:recent)
      end
    end
  end
end