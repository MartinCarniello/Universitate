class UserMailer < ApplicationMailer

  def welcome_email(user)
    mail(to: user.email, subject: 'Welcome to UniversitaTe')
  end

  def rating_email(user)
    @user = user
    mail(to: @user.email, subject: 'Someone made a comment about you')
  end
end
