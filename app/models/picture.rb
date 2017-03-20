# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string
#  user_id    :integer
#

class Picture < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :avatar, presence: true
  validates :comment, length: { maximum: 255 }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
