json.comments @comments, :id, :body, :parent_comment_id if params[:user_id].present?
if params[:photo_id].present?
  json.comments @comments.where(parent_comment_id: nil), partial: '/api/v1/comments/comment', as: :comment
end
