class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.member(current_user).order_recents.page(params[:page])
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
    @page = params[:page] || 1
    @conversation = Conversation.find(params[:id])
    @message = Message.new(conversation: @conversation, sender: current_user, receiver: @conversation.decorate.linked_user)
    @messages = @conversation.messages.order_recents.page(@page)
    @conversation.clear_messages_count!(current_user)
  end

  def create
    @message = Message.create(message_required_params)
    redirect_to conversation_path(@message.conversation_id)
  end

  def update
    @message = Message.create(message_required_params)
    ActionCable.server.broadcast "messages_#{@message.conversation_id}", message: @message.message, username: @message.sender.decorate.display_name, datetime: @message.decorate.datetime_creation
  end

  def load_more_messages
    @page = params[:page]
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.order_recents.page(@page)
    flash.now[:danger] = I18n.t('views.conversations.show.conversations_table.load_failed') if @messages.empty?
  end

  private

  def message_required_params
    params.require(:message).permit(:sender_id, :receiver_id, :conversation_id, :message)
  end
end
