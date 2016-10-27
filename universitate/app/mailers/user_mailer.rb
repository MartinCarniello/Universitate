class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.subject.welcome_message'))
  end

  def rating_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.subject.rating_email_message'))
  end

  def group_lesson_modified(user,lesson)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.subject.group_lesson_modified_message', subject_name: lesson.subject.name))
  end
end
