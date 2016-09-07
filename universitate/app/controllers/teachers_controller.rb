class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @teachers  = @search.results.with_role(:teacher)
  end

  def show
    @teacher = User.find(params[:id])
    @teacherProfile= TeacherProfile.find(params[:id])
    @experience = TeacherExperience.find(@teacherProfile.id)
  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end
end
