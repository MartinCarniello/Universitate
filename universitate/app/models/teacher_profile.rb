# == Schema Information
#
# Table name: teacher_profiles
#
#  id                 :integer          not null, primary key
#  description        :string
#  user_id            :integer
#  hour_rate          :decimal(, )
#  type_of_service_cd :integer
#

class TeacherProfile < ApplicationRecord
  extend SimpleEnum::Attribute

  as_enum :type_of_service, both: 0, home: 1, at_home: 2

  belongs_to :user
  has_one :location, through: :user
  has_and_belongs_to_many :subjects
  has_many :works, -> { where(experience_type: 'WORK').order('period_start DESC')}, class_name: "TeacherExperience", :dependent => :destroy
  has_many :studies, -> { where(experience_type: 'STUDY').order('period_start DESC')}, class_name: "TeacherExperience", :dependent => :destroy
  has_many :ratings
  has_many :group_lessons
  has_and_belongs_to_many :levels


  validates :description, :hour_rate, :subject_ids, presence: true

  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :studies, reject_if: :all_blank, allow_destroy: true

  def avg_rating
    ratings.average(:value)
  end
end
