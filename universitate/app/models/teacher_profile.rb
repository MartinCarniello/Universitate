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
  has_many :teacher_experiences, :dependent => :destroy

  #has_many :works, -> { where(experience_type: 'WORK')}, class_name: "TeacherExperience", :dependent => :destroy
  #has_many :studies, -> { where(experience_type: 'STUDY')}, class_name: "TeacherExperience", :dependent => :destroy

  validates :description, presence: true

  accepts_nested_attributes_for :teacher_experiences
end
