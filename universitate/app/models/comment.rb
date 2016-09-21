# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  comment            :string
#  comment_replied_id :integer
#

class Comment < ApplicationRecord
  belongs_to :rating
  has_one :comment, :class_name => "Rating", :foreign_key => "comment_replied_id"
end
