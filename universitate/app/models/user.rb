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
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  mount_uploader :avatar, AvatarUploader

  has_one :teacher_profile
  has_one :location
  has_many :subjects, through: :teacher_profile
  has_many :ratings, through: :teacher_profile
  has_and_belongs_to_many :group_lessons, join_table: 'group_lessons_users'
  has_many :identities, dependent: :destroy


  acts_as_mappable :through => :location

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
  scope :order_by_distance, -> (lat, lng) { joins(:location).by_distance(origin: [lat, lng]) }

  delegate :description, :hour_rate, :user_id, :works, :studies, :subjects, :rating, :avg_rating, to: :teacher_profile, prefix: true

  accepts_nested_attributes_for :teacher_profile
  accepts_nested_attributes_for :location

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      if identity.user != user
        identity.user = user
        identity.save!
      end
    user
    end

  end


  def conversations
    Conversation.member(self)
  end

  def unreaded_messages
    conversations.unreaded_messages(id).first.sum || 0
  end

  def has_already_been_rate_by?(user)
    ratings.by_user(user).first
  end

  def logged?(provider)
    Identity.where(provider: provider, user_id: self.id).present?
  end


  def self.find_for_google_oauth2(auth)

    identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_create do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      identity.user = User.find_by email:(auth.info.email)
    end

    # user.token = auth.credentials.token
    # user.refresh_token = auth.credentials.refresh_token
    # user.save
    return User.find_by email:(auth.info.email)
  end

  def self.find_for_linkedin(auth)

    identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_create do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      identity.user = User.find_by email:(auth.info.email)
    end

    # user.token = auth.credentials.token
    # user.refresh_token = auth.credentials.refresh_token
    # user.save
    return User.find_by email:(auth.info.email)
  end

end
