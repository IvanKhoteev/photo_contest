class PhotosController < ApplicationController

  def index
    @photos = sorting(Photo.all.where(aasm_state: :approved).page(params[:page]))
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.likes_count = 0
    @photo.save
    if @photo.save
      flash[:success] = "Фотография отправлена на модерацию!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show_collection
    @photos = sorting(Photo.where(user_id: current_user.id, aasm_state: [:approved, :moderated]).page(params[:page]))
  end

  def search
    ids =[]
    User.all.each {|n| ids << n.id if n.name.mb_chars.downcase.include?(params[:q].mb_chars.downcase) }
    @photos = Photo.where(user_id: ids, aasm_state: :approved).page(params[:page])
    flash.now[:warning] = "По Вашему запросу '#{params[:q]}' ничего не было найдено." unless @photo_galleries.any?
  end

  private

    def photo_params
      params.require(:photo).permit(:photo_name, :photo, :user_id)
    end

end
