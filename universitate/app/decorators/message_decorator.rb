class MessageDecorator < Draper::Decorator
  delegate_all
  
  def css_class
    h.current_user.id == sender_id ? 'right' : 'left'
  end

  def sender_avatar_url
    sender.avatar_url
  end

  def sender_display_name
    h.current_user.id == sender_id ? 'Yo' : sender.decorate.display_name
  end

  def message
    object.message
  end

  def datetime_creation
    created_at.strftime("%m/%d/%y %I:%M")
  end
end