class MessageDecorator < Draper::Decorator
  delegate_all
  
  def css_class
    current_user_sender? ? 'left' : 'right'
  end

  def sender_avatar_url
    sender.avatar_url
  end

  def sender_display_name
    current_user_sender? ? 'Yo' : sender.decorate.display_name
  end

  def message
    object.message
  end

  def datetime_creation
    created_at.strftime("%m/%d/%y %I:%M")
  end

  def current_user_sender?
    h.current_user.id == sender_id
  end
end