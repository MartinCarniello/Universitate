# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  comment            :string
#  comment_replied_id :integer
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
