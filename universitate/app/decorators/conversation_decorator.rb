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
    h.current_user.id == first_user_id ? second_user : first_user
  end
end