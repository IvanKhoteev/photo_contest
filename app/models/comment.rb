# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  body              :text
#  user_id           :integer
#  photo_id          :integer
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_comments_on_parent_comment_id  (parent_comment_id)
#  index_comments_on_photo_id           (photo_id)
#  index_comments_on_user_id            (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  has_many   :sub_comments, class_name: 'Comment', foreign_key: 'parent_comment_id' 
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: 'parent_comment_id'
end
