class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @users  = @search.results.with_role(:teacher)
  end

  def show

  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end
end
