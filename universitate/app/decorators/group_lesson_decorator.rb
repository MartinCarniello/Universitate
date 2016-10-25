class GroupLessonDecorator < Draper::Decorator
  delegate_all

  def day_and_hour
    object.day_and_hour.strftime("%d/%m/%y %I:%M")
  end

end
