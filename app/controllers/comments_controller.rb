class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    
  end

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params.merge(user_id: current_user.id))
    redirect_to request.referer
  end

  def create_sub_comment
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.create(comment_params.merge(user_id: current_user.id))
    @comment.parent_comment_id = params[:parent_comment_id]

    while @comment.parent_comment do
      parent_comment = @comment.parent_comment
      parent_comment.updated_at = @comment.updated_at
      parent_comment.save
      @comment = parent_comment
    end
    redirect_to root_path
    
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end

end
