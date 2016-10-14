class UserMailer < ApplicationMailer

  def welcome_email(user)
    mail(to: user.email, subject: 'Welcome to UniversitaTe')
  end

  def rating_email(user)
    @user = user
    mail(to: @user.email, subject: 'Someone made a comment about you')
  end

  def group_lesson_modified(user,lesson)
    @user = user
    mail(to: @user.email, subject: 'Your group lesson of #{lesson.subject.name} was modified')
  end
end
