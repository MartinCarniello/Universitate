class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @teachers  = @search.results.with_role(:teacher)
  end

  def show
    @teacher = User.find(params[:id])
  end

  def edit
  end
  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end

  def new
    @teacher_profile = current_user.build_teacher_profile
    @subjects = Subject.all()
  end

  def create
    if current_user.create_teacher_profile(params.require(:teacher_profile).permit(:description, :hour_rate)).valid?
      current_user.add_role(:teacher)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      redirect_to root_path
    else
      @teacher_profile = current_user.teacher_profile
      render :new
    end
  end
end
