class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.member(current_user).order_recents
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new(conversation: @conversation, sender: current_user, receiver: @conversation.decorate.linked_user)
    @messages = @conversation.messages
    @conversation.clear_messages_count!(current_user)
  end

  def update
    @message = Message.create(message_required_params)
  end

  private

  def message_required_params
    params.require(:message).permit(:sender_id, :receiver_id, :conversation_id, :message)
  end
end
