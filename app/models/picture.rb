class Picture < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :avatar, presence: true
  validates :comment, length: { maximum: 255 }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes
  has_many :liking_user, through: :likes, dependent: :destroy
end
