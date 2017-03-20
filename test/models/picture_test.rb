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

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
