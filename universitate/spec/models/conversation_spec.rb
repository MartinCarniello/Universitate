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

require "rails_helper"

RSpec.describe Conversation, type: :model do
  describe "increment_message_count! method for conversation :one" do
    it "should increment first_user_messages_count by one when user :two send a message to user :one" do
      conversation = conversations(:one)
      messages_count = conversation.first_user_messages_count

      conversation.increment_message_count!(users(:one))
      assert_equal conversation.reload.first_user_messages_count, messages_count + 1
    end

    it "should increment second_user_messages_count by one when user :one send a message to user :two" do
      conversation = conversations(:one)
      messages_count = conversation.second_user_messages_count

      conversation.increment_message_count!(users(:two))
      assert_equal conversation.reload.second_user_messages_count, messages_count + 1
    end
  end

  describe "clear_messages_count! method for conversation :one" do
    it "should be zero for each members" do
      conversation = conversations(:one)
      conversation.increment_message_count!(users(:one))
      conversation.increment_message_count!(users(:two))

      conversation.clear_messages_count!(users(:one))
      conversation.clear_messages_count!(users(:two))
      assert_equal conversation.reload.first_user_messages_count, 0
      assert_equal conversation.reload.second_user_messages_count, 0
    end
  end
end

