class PhotosController < ApplicationController

  def index
    @photos = params[:sorting] ? Photo.approved.page(params[:page]).reorder(params[:sorting]) : Photo.approved.page(params[:page])
    @photos = Photo.approved.page(params[:page]).includes(:user).where(users: { name: User.select(:name).where("name ILIKE :sub_name", { sub_name: "%"+params[:search_by_users_name]+"%" }) } ).page(params[:page]).reorder(params[:sorting]) if params[:search_by_users_name]
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
    @photos = Photo.where(user_id: current_user, aasm_state: [:approved, :moderated]).page(params[:page])
  end

  def instagram_search
    @client = Instagram.client(access_token: ENV['ACCESS_TOKEN'])
    @tags = @client.tag_search(params[:q])
  end

  private

    def photo_params
      params.require(:photo).permit(:name, :photo)
    end

end
