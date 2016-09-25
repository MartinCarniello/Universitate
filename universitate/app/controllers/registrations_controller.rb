class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :gender, :password, :password_confirmation))

    if @user.save
      sign_in(:user, @user)
      redirect_to root_path
      # FIXME: Remove comments when setup mailer in production
      # UserMailer.welcome_email(@user).deliver
    else
      render :new
    end
  end

  def update
    super
  end
end
