# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  picture_id :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  acts_as_taggable_on :labels # post.label_list が追加される
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
  belongs_to :user
  belongs_to :picture
end
