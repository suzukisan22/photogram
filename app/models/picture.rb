class Picture < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :avatar, presence: true
  validates :comment, length: { maximum: 255 }

  belongs_to :user
end
