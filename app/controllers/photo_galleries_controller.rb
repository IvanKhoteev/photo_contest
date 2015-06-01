class PhotoGalleriesController < ApplicationController

 def new 	
 end

 def create
   @photo_gallery = current_user.photo_galleries.build(photo_gallery_params)
   if @photo_gallery.save
     flash[:success] = "Фотография отправлена!"
     redirect_to @photo_gallery
   else
     render 'new'
   end
 end

 def show
  @photo_gallery = PhotoGallery.find(params[:id])
 end

  private

    def photo_gallery_params
      params.require(:photo_gallery).permit(:photo_name, :photography)
    end

end
