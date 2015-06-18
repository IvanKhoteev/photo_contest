class LikesController < ApplicationController

  def create
  	@photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build(user_id: current_user.id)
    if @like.valid?    
  	  @like.save
  	  flash[:success] = "Ваш голос принят!"
      redirect_to request.referer
    else
      flash[:warning] = "Вы уже голосовали за это фото!"
      redirect_to request.referer
    end  	
  end

  
end
