require 'sidekiq/api'
ActiveAdmin.register Photo do
  index do
    selectable_column
    column I18n.t("active_admin.photos.name"), :name
    column I18n.t("active_admin.photos.photo"), :photo do |pg|
      image_tag pg.photo.thumb
    end
    column I18n.t("active_admin.photos.author"), :author do |pg|
      User.find(pg.user_id).name
    end
    column I18n.t("active_admin.photos.status"), :aasm_state
    column I18n.t("active_admin.photos.moderation"), :moderation do |pg|
      columns do
        column do
          link_to I18n.t(:approve), approve_admin_photo_path(pg) unless pg.aasm_state == 'approved'
        end
        column do
          link_to I18n.t(:ban), ban_admin_photo_path(pg) unless pg.aasm_state == 'banned'
        end
      end
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
