class ChatsController < ApplicationController
  def index
    @conversations = Conversation.sender(current_user)
  end
end
