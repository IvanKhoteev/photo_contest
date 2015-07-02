# Controller for likes
class LikesController < ApplicationController
  def create
    photo = Photo.find(params[:photo_id])
    outcome = Likes::Create.run(photo: photo, user: current_user)
    if outcome.success?
      flash[:success] = 'Ваш голос учтен!'
      redirect_to root_path
    else
      flash[:warning] = 'Вы уже голосовали за это фото!'
      redirect_to request.referer
    end
  end
end
