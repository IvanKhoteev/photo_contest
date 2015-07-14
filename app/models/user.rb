# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string           not null
#  uid        :string           not null
#  name       :string
#  image_url  :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_provider          (provider)
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_uid               (uid)
#

class User < ActiveRecord::Base
  has_many :photos
  has_many :comments
  has_many :likes, through: :photos
  delegate :name,  to: :class, prefix: :author

  scope :searched, -> (name) { where('users.name ILIKE ?', "%#{name}%") }
  scope :recent, -> { order(created_at: :desc).limit(5) }

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      user.url = auth_hash['info']['urls'][user.provider.capitalize] if auth_hash['info']['urls']
      user.save!
      user
    end
  end
end
