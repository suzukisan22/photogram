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
  acts_as_taggable_on :labels # post.label_list が追加される
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
  mount_uploader :avatar, AvatarUploader

  validates :avatar, presence: true
  validates :comment, length: { maximum: 255 }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
