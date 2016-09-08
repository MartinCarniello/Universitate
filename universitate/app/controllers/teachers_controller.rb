class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @teachers  = @search.results.with_role(:teacher)
  end

  def show
    @teacher = User.find(params[:id])
  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end

  def new
    @teacher_profile=TeacherProfile.new
  end

def create
  redirect_to root_path
end
end
