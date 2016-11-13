class GroupLessonDecorator < Draper::Decorator
  delegate_all

  def day_and_hour
    object.day_and_hour.try(:strftime, "%d/%m/%y %H:%M")
  end

end
