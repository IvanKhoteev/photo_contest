# ...
module API
  # ...
  module V1
    # ...
    module Users
      class CommentsController < ApplicationController
        layout false

        def index
          comments = Comment.where(user_id: params[:user_id])
          render json: comments, user_id: params[:user_id], status: 200
        end
      end
    end
  end
end
