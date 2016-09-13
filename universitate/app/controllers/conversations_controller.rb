class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.member(current_user)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end
end
