require 'sidekiq/api'
ActiveAdmin.register Photo do
  index do
    selectable_column
    column :name
    column  :photo do |pg|
      image_tag pg.photo.thumb
    end
    column :author do |pg|
      User.find(pg.user_id).name
    end
    column :aasm_state
    actions defaults: false, dropdown: true do |pg|
      item I18n.t(:approve), approve_admin_photo_path(pg)
      item I18n.t(:ban), ban_admin_photo_path(pg)
    end
    actions
  end

  member_action :approve do
    resource.approve!
    redirect_to admin_photos_path
  end

  member_action :ban do
    resource.ban!
    RemovePhotoWorker.perform_in(30.minutes, params[:id])
    redirect_to admin_photos_path
  end
end
