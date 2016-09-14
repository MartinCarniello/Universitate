# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  receiver_id     :integer
#  message         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer
#

class Message < ApplicationRecord
  before_create :assign_conversation, :increment_receiver_message_count!

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :conversation

  validates :sender_id, :receiver_id, :message, presence: true

  scope :sender, -> (sender) { where(sender: sender) }
  scope :order_recents, -> { order('created_at DESC') }

  private

  def assign_conversation
    self.conversation = if conversation = Conversation.members(sender, receiver).first
      conversation
    else
      Conversation.create(first_user: sender, second_user: receiver)
    end
  end

  def increment_receiver_message_count!
    conversation.increment_message_count!(receiver)
  end
end
