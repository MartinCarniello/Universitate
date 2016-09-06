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
  has_and_belongs_to_many :subjects
  has_many :teacher_experience
end
