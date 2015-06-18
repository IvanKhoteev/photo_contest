class PhotosController < ApplicationController

  def index
    @photos = sorting(Photo.approved.page(params[:page]))
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.create(photo_params)
    if @photo.save
      flash[:success] = "Фотография отправлена на модерацию!"
      redirect_to root_path
    else
      render 'new'
    end


 #   outcome = Photos::Create.run(photo_params.merge(user: current_user))
 #   if outcome.success?
 #     @photo = outcome.result
 #     flash[:success] = "Фотография отправлена на модерацию!"
 #     redirect_to root_path
 #   else
 #     render outcome.errors
 #   end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def show_collection
    @photos = sorting(Photo.where(user_id: current_user, aasm_state: [:approved, :moderated]).page(params[:page]))
  end

  def search
    flash.now[:warning] = "По Вашему запросу '#{params[:q]}' ничего не было найдено." unless @photos.any?
  end

  def instagram_search
    @client = Instagram.client(access_token: ENV['ACCESS_TOKEN'])
    @tags = @client.tag_search(params[:q])
  end

  private

    def photo_params
      params.require(:photo).permit(:name, :photo)
    end

    def sorting (list)
      sorting = case params[:sorting]
                  when 'ca' then 'created_at ASC'
                  when 'cd' then 'created_at DESC'
                  when 'la' then 'likes_count ASC'
                  when 'ld' then 'likes_count DESC'
                else
                  'created_at DESC'
                end
      list.order(sorting)
    end

end
