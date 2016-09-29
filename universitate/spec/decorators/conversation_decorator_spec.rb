require "rails_helper"

RSpec.describe 'ConversationDecorator', type: :controller do
  describe "linked_user_display_name method for conversation which" do
    it "is seeing by Pedro Perez should be Pablo Gonzalez" do
      sign_in(users(:one))
      conversation = conversations(:one).decorate

      assert_equal conversation.linked_user_display_name, 'Pablo Gonzalez'
    end

    it "is seeing by Pablo Gonzalez should be Pedro Perez" do
      sign_in(users(:two))
      conversation = conversations(:one).decorate

      assert_equal conversation.linked_user_display_name, 'Pedro Perez'
    end
  end

  describe "last_message method for conversation :one" do
    it "should be Todo bien, vos?" do
      sign_in(users(:one))
      conversation = conversations(:one).decorate

      Message.last.update_attributes!(created_at: Time.now)
      assert_equal conversation.last_message.message, 'Todo bien, vos?'
    end
  end

  describe "unreaded_messages method for conversation :one" do
    it "for user Pedro Perez should be 1" do
      sign_in(users(:one))
      Message.create(conversation: conversations(:one), sender: users(:two), receiver: users(:one), message: 'Un mensaje')
      conversation = conversations(:one).reload.decorate

      assert_equal conversation.unreaded_messages, 1
    end

    it "for user Pablo Gonzalez should be 1" do
      sign_in(users(:two))
      Message.create(conversation: conversations(:one), sender: users(:one), receiver: users(:two), message: 'Un mensaje')
      conversation = conversations(:one).reload.decorate

      assert_equal conversation.unreaded_messages, 1
    end
  end

  describe "last_message_with_name method for conversation :one" do
    it "for user Pedro Perez should be Pablo Gonzalez: Todo bien, vos?" do
      sign_in(users(:one))
      conversation = conversations(:one).decorate

      Message.last.update_attributes!(created_at: Time.now)
      assert_equal conversation.last_message_with_name, 'Pablo Gonzalez: Todo bien, vos?'
    end

    it "for user Pablo Gonzalez should be Yo: Todo bien, vos?" do
      sign_in(users(:two))
      conversation = conversations(:one).decorate

      Message.last.update_attributes!(created_at: Time.now)
      assert_equal conversation.last_message_with_name, 'Yo: Todo bien, vos?'
    end
  end
end