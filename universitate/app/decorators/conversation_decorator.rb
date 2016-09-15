class ConversationDecorator < Draper::Decorator
  delegate_all
  
  def linked_user_avatar_url
    linked_user.avatar_url
  end

  def linked_user_display_name
    linked_user.decorate.display_name
  end

  def last_message
    messages.order_recents.first
  end

  def linked_user
    current_user_sender? ? second_user : first_user
  end

  def unreaded_messages
    current_user_sender? ? first_user_messages_count : second_user_messages_count
  end

  def last_message_with_name
    last_message_aux = last_message
    last_message_aux.sender == h.current_user ? "Yo: #{last_message_aux.message}" : "#{last_message.sender.decorate.display_name}: #{last_message_aux.message}"
  end

  private

  def current_user_sender?
    h.current_user.id == first_user_id
  end
end