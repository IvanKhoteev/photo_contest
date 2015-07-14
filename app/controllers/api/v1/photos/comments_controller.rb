# ...
module API
  # ...
  module V1
    # ...
    module Photos
      class CommentsController < ApplicationController
        layout false

        def index
          comments = Comment.where(photo_id: params[:photo_id], parent_comment_id: nil)
          render json: comments, status: 200
        end
      end
    end
  end
end
