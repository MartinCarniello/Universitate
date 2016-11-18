# == Schema Information
#
# Table name: group_lessons
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  day_and_hour       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  subject_id         :integer
#

class GroupLesson < ApplicationRecord
  paginates_per 15
  belongs_to :teacher_profile
  has_and_belongs_to_many :students, class_name: 'User', join_table: 'group_lessons_users'
  belongs_to :subject

  validates :teacher_profile_id, :day_and_hour, :subject_id, presence: true

  scope :my_lessons, -> (user) { where(teacher_profile: user.teacher_profile) }
  scope :all_except, -> (user) { where.not(teacher_profile: user.teacher_profile) }
  scope :with_subjects , -> (subject) { where(subject: subject) }
  scope :non_expired, -> {where('day_and_hour >= ?', DateTime.now)}

  delegate :name, to: :subject, prefix: true
  delegate :user, to: :teacher_profile, prefix: true

end
