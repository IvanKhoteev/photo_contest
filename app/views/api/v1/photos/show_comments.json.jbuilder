json.photo @photos, :id, :name, :user_id
json.comments @photos.comments.where(parent_comment_id: nil), partial: '/api/v1/photos/comment', as: :comment