ActiveAdmin.register Photo do

  index do
    selectable_column
    column :photo_name
    column :photo do |pg|
      image_tag pg.photo
    end
    column "Current Status", :aasm_state
    column "Moderation", :moderation do |pg|
      columns do
        column do
          link_to 'Approve', approve_admin_photo_path(pg) unless pg.aasm_state == 'approved'
        end
        column do
          link_to 'Ban', ban_admin_photo_path(pg) unless pg.aasm_state == 'banned'
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
    redirect_to admin_photos_path
  end

end

