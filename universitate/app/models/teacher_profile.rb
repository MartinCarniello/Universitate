# == Schema Information
#
# Table name: teacher_profiles
#
#  id          :integer          not null, primary key
#  description :string
#  user_id     :integer
#  hour_rate   :decimal(, )
#

class TeacherProfile < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :subjects
  has_many :teacher_experience

  validates :description, presence: true
end
