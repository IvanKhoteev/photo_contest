json.comment comment, :id, :body, :user_id, :parent_comment_id
if comment.sub_comments
  json.comments comment.sub_comments, partial: '/api/v1/comments/comment', as: :comment
end
