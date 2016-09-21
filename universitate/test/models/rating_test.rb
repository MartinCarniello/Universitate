# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  value              :integer
#  comment_id         :integer
#

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
