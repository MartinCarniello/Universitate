class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.with_role(:teacher)
  end

  def show

  end
end
