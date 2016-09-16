# == Schema Information
#
# Table name: conversations
#
#  id                         :integer          not null, primary key
#  first_user_id              :integer
#  second_user_id             :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  first_user_messages_count  :integer          default(0)
#  second_user_messages_count :integer          default(0)
#

class Conversation < ApplicationRecord
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  has_many :messages

  validates :first_user_id, :second_user_id, presence: true

  scope :member, -> (member) { where('first_user_id = ? OR second_user_id = ?', member.id, member.id) }
  scope :members, -> (sender, receiver) { where('(first_user_id = ? AND second_user_id = ?) OR (first_user_id = ? AND second_user_id = ?)', sender.id, receiver.id, receiver.id, sender.id) }
  scope :unreaded_messages, -> (user_id) { select("Sum(CASE WHEN first_user_id = #{user_id} THEN first_user_messages_count ELSE second_user_messages_count END) AS sum").reorder('') }
  scope :order_recents, -> { order('updated_at DESC') }

  def increment_message_count!(user)
    first_user_id == user.id ? self.first_user_messages_count += 1 : self.second_user_messages_count += 1
    save!
  end

  def clear_messages_count!(user)
    update_column((first_user_id == user.id ? :first_user_messages_count : :second_user_messages_count), 0)
  end
end
