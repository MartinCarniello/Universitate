class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    User.create!(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))
    redirect_to root_path
  end

  def update
    super
  end
end 