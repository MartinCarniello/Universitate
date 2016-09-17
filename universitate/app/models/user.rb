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
  GENDER= {MALE: 'M', FEMALE:'F'}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_one :teacher_profile
  has_many :subjects, through: :teacher_profile
  has_many :teacher_experiences, through: :teacher_profile

  validates :gender, inclusion: {in: ['F','M']}

  scope :with_display_name, -> (display_name) { where("first_name || ' ' || last_name ILIKE ?", "%#{display_name}%") }
  scope :with_subjects , -> (subject) { joins(teacher_profile: :subjects).where("subjects.id = ?", subject) }

  delegate :description, :hour_rate, :user_id, :teacher_experiences, :subjects, to: :teacher_profile, prefix: true

  accepts_nested_attributes_for :teacher_profile, :teacher_experiences


  def conversations
    Conversation.member(self)
  end

  def unreaded_messages
    conversations.unreaded_messages(id).first.sum || 0
  end
end
