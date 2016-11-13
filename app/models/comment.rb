class Comment < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :picture, dependent: :destroy
end
