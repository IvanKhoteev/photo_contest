json.comment comment, :id, :body, :user_id, :parent_comment_id
if comment.sub_comments
  json.sub_comments comment.sub_comments, partial: '/api/v1/photos/comment', as: :comment
end

