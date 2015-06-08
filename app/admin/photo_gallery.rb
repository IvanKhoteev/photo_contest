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
<<<<<<< HEAD
        if pg.aasm_state == 'moderated'
=======
        if pg.aasm_state == 'moderated' then
>>>>>>> b07a85bd32e2d2b33fd9679ee601c595e103292d
          column do
      	    link_to 'Approve', approve_admin_photo_gallery_path(pg)
          end
          column do
            link_to 'Ban', ban_admin_photo_gallery_path(pg)
          end
<<<<<<< HEAD
        elsif pg.aasm_state == 'approved'
=======
        elsif pg.aasm_state == 'approved' then
>>>>>>> b07a85bd32e2d2b33fd9679ee601c595e103292d
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

