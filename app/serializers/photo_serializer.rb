# ...
class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo_url, :likes_count, :user_id

  def photo_url
    object.photo.url
  end
end
