# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  value              :integer
#  comment            :string
#  reply              :string
#  user_id            :integer
#

class Rating < ApplicationRecord
  paginates_per 4

  belongs_to :teacher_profile
  belongs_to :user

  validates :teacher_profile_id, :value, :comment, :user_id, presence: true
  validates :value, inclusion: { in: 1..5 }

  scope :by_user, -> (user) { where(user: user) }
  scope :recents, -> { order('id DESC') }

  delegate :user, to: :teacher_profile, prefix: true
end
