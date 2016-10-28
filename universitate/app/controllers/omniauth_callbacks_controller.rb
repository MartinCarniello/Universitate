class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
    if @user
      redirect_to root_path
    else
      redirect_to new_user_session_path, notice: 'Access Denied.'
    end
  end

  def linkedin
    @user = User.find_for_linkedin(request.env["omniauth.auth"])
    if @user
      redirect_to root_path
    else
      redirect_to new_user_session_path, notice: 'Access Denied.'
    end
  end

end
