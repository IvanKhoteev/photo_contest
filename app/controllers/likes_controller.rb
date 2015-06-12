class LikesController < ApplicationController

  def create
  	@photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build
    @like.user_id = current_user.id
    if @like.valid?    
  	  @like.save
  	  flash[:success] = "Ваш голос принят!"
      redirect_to root_path
    else
      flash[:warning] = "Вы уже голосовали за это фото!"
      redirect_to root_path
    end  	
  end

  
end
