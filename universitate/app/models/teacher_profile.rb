# == Schema Information
#
# Table name: teacher_profiles
#
#  id          :integer          not null, primary key
#  description :string
#  subjects    :string           is an Array
#  user_id     :integer
#

class TeacherProfile < ApplicationRecord
  belongs_to :user
end
