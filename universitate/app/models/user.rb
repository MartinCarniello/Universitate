# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  first_name             :string
#  last_name              :string
#  date_of_birth          :datetime
#  gender                 :string
#

class User < ApplicationRecord
  rolify
  GENDER = { MALE: 'M', FEMALE: 'F' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_one :teacher_profile
  has_one :location
  has_many :subjects, through: :teacher_profile
  has_many :ratings, through: :teacher_profile

  validates :first_name, :last_name, presence: true
  validates :gender, inclusion: {in: ['F','M']}

  scope :teachers, -> { joins(:roles).where('roles.name = ?', 'teacher') }
  scope :with_display_name, -> (display_name) { where("first_name || ' ' || last_name ILIKE ?", "%#{display_name}%") }
  scope :with_subjects , -> (subject) { joins(teacher_profile: :subjects).where("subjects.id = ?", subject) }
  scope :except_user, -> (user) { where.not(id: user.id) }
  scope :best_rated, -> { select('users.*, (CASE WHEN count(ratings.*) = 0 THEN 0 ELSE avg(ratings.value) END) AS user_rating')
                          .joins(:teacher_profile)
                          .joins('LEFT OUTER JOIN ratings ON teacher_profiles.id = ratings.teacher_profile_id')
                          .group('users.id')
                          .order('user_rating DESC')
                        }
  

  delegate :description, :hour_rate, :user_id, :works, :studies, :subjects, :rating, :avg_rating, to: :teacher_profile, prefix: true

  accepts_nested_attributes_for :teacher_profile
  accepts_nested_attributes_for :location


  def conversations
    Conversation.member(self)
  end

  def unreaded_messages
    conversations.unreaded_messages(id).first.sum || 0
  end

  def has_already_been_rate_by?(user)
    ratings.by_user(user).first
  end
end
