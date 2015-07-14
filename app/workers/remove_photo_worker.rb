# ...
class RemovePhotoWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    if photo.banned?
      photo.remove_photo!
      photo.destroy
    end
  end
end
