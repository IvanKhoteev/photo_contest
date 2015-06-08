ActiveAdmin.register PhotoGallery do

  index do
    selectable_column
    column :photo_name
    column :photo do |pg|
      image_tag pg.photography
    end
    column "Current Status", :aasm_state
    column "Moderation", :moderation do |pg|
      columns do
        if pg.aasm_state == 'moderated'
          column do
      	    link_to 'Approve', approve_admin_photo_gallery_path(pg)
          end
          column do
            link_to 'Ban', ban_admin_photo_gallery_path(pg)
          end
        elsif pg.aasm_state == 'approved'
          column do
            link_to 'Ban', ban_admin_photo_gallery_path(pg)
          end
        else
          column do
            link_to 'Allow', allow_admin_photo_gallery_path(pg)
          end
        end
      end
    end
    actions
  end

  member_action :approve do
    resource.approve!
    redirect_to admin_photo_galleries_path
  end

  member_action :ban do
    resource.ban!
    redirect_to admin_photo_galleries_path
  end

  member_action :allow do
    resource.allow!
    redirect_to admin_photo_galleries_path
  end

end

