# Controller for photography
class PhotosController < ApplicationController
  def index
    @photos = Photo.approved.page(params[:page])
    @photos = @photos.reorder(params[:sorting]) if params[:sorting].present?
    @photos = @photos.filtered_by_user_sub_name(params[:search_by_users_name]) if params[:search_by_users_name].present?
  end

  def new
    @photo = Photo.new
  end

  def create
    outcome = Photos::Create.run(photo_params.merge(user: current_user))
    if outcome.success?
      @photo = outcome.result
      flash[:success] = 'Фотография отправлена на модерацию!'
      redirect_to root_path
    else
      render outcome.errors.symbolic
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def show_collection
    @photos = Photo.where(user_id: current_user, aasm_state: [:approved, :moderated]).page(params[:page])
  end

  def instagram_search
    @client = Instagram.client(access_token: ENV['ACCESS_TOKEN'])
    @images_url = []
    @tag = (params[:q].split)[0]
    for media_item in @client.tag_recent_media(URI.encode(@tag), count: 50)
      @images_url << media_item.images.thumbnail.url
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :photo)
  end
end
