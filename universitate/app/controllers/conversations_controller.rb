class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.member(current_user).order_recents
  end

  def new
    @linked_user = User.find(params[:linked_user_id])

    if @conversation = Conversation.members(current_user, @linked_user).first
      redirect_to conversation_path(@conversation)
    else
      @conversation = Conversation.new(first_user: current_user, second_user: @linked_user)
      @message = Message.new(conversation: @conversation, sender: current_user, receiver: @linked_user)
      @messages = @conversation.messages
      render :show
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new(conversation: @conversation, sender: current_user, receiver: @conversation.decorate.linked_user)
    @messages = @conversation.messages
    @conversation.clear_messages_count!(current_user)
  end

  def create
    @message = Message.create(message_required_params)
    redirect_to conversation_path(@message.conversation_id)
  end

  def update
    @message = Message.create(message_required_params)
  end

  private

  def message_required_params
    params.require(:message).permit(:sender_id, :receiver_id, :conversation_id, :message)
  end
end
