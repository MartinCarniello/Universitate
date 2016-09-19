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

  has_many :works, -> { where(experience_type: 'WORK').order('period_start DESC')}, class_name: "TeacherExperience", :dependent => :destroy
  has_many :studies, -> { where(experience_type: 'STUDY').order('period_start DESC')}, class_name: "TeacherExperience", :dependent => :destroy

  validates :description, presence: true

  accepts_nested_attributes_for :works
  accepts_nested_attributes_for :studies
end
