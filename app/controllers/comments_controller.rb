class CommentsController < ApplicationController

  def create
    @photo_gallery = PhotoGallery.find(params[:photo_gallery_id])
    @comment = @photo_gallery.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to root_path
  end
 
  private
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end

end
