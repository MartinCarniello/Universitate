# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  value              :integer
#  comment_id         :integer
#

class Rating < ApplicationRecord
  belongs_to :teacher_profile
  has_one :comment
end
