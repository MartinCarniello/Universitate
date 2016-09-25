class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    if user = User.create(params.require(:user).permit(:first_name, :last_name, :email, :gender, :password, :password_confirmation))
      sign_in(:user, user)
      redirect_to root_path
      UserMailer.welcome_email(user).deliver
    end
  end

  def update
    super
  end
end
