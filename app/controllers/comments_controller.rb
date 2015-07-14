# Controller for comments
class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    photo = Photo.find(params[:photo_id])
    outcome = Comments::Create.run(photo: photo, user: current_user,
                                   body: params[:comment]['body'],
                                   parent_comment_id: params[:parent_comment_id])
    if outcome.success?
      flash[:success] = 'Комментарий добавлен!'
      redirect_to root_path
    else
      render html: outcome.errors.message
    end
  end
end
