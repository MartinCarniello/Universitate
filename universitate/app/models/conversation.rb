class Conversation < ApplicationRecord
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  has_many :messages

  validates :first_user_id, :second_user_id, presence: true

  scope :member, -> (member) { where('first_user_id = ? OR second_user_id = ?', member.id, member.id) }
  scope :members, -> (sender, receiver) { where('(first_user_id = ? AND second_user_id = ?) OR (first_user_id = ? AND second_user_id = ?)', sender.id, receiver.id, receiver.id, sender.id) }
end