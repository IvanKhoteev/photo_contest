class LikesController < ApplicationController

  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build(user_id: current_user.id)
    @like.save if @like.valid?

    if @like.save  
      respond_to do |format|
        format.html {redirect_to request.referer, notice: "Successfully liked!"}
        format.js {}
      end     
    end   
  end

  
end
