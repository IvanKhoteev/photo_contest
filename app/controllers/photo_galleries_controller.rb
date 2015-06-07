class PhotoGalleriesController < ApplicationController

  def index
    sorting = case params[:sorting]
                when 'ca' then 'created_at ASC'
                when 'cd' then 'created_at DESC'
                when 'la' then 'likes_count ASC'
                when 'ld' then 'likes_count DESC'
              else
                'created_at DESC'
              end
    @photo_galleries = (PhotoGallery.all).order(sorting)
  end

  def new
    @photo_gallery = PhotoGallery.new
  end

  def create
    @photo_gallery = current_user.photo_galleries.build(photo_gallery_params)
    if @photo_gallery.save
      flash[:success] = "Фотография отправлена!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @photo_galleries = PhotoGallery.where(user_id: current_user.id)
  end

  private

    def photo_gallery_params
      params.require(:photo_gallery).permit(:photo_name, :photography)
    end

end
