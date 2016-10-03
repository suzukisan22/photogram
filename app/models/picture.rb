class Picture < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
end
