class Picture < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :avatar, presence: true

  belongs_to :user
end
