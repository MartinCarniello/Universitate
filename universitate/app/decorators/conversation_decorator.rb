class ConversationDecorator < Draper::Decorator
  delegate_all
  
  def linked_user_avatar_url
    linked_user.avatar_url
  end

  def linked_user_display_name
    linked_user.decorate.display_name
  end

  def last_message
    messages.order_recents.first.message
  end

  def linked_user
    current_user_sender? ? second_user : first_user
  end

  def unreaded_messages
    current_user_sender? ? first_user_messages_count : second_user_messages_count
  end

  def last_message_with_name
    "#{current_user_sender? ? 'Yo' : linked_user.decorate.display_name}: #{last_message}"
  end

  private

  def current_user_sender?
    h.current_user.id == first_user_id
  end
end