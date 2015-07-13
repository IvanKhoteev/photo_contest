# ....
module API
  # ...
  module V1
    # ...
    class UsersController < ApplicationController
      layout false

      def index
        users = User.all
        users = users.searched(params[:search]) if params[:search].present?
        users = users.recent if params.include?(:recent)
        render json: users, status: 200
      end

      def show
        user = User.find(params[:id])
        render json: user, user_id: user.id, status: 200
      end
    end
  end
end
