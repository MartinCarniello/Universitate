class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @teachers  = @search.results.with_role(:teacher)
  end

  def show
    @teacher = User.find(params[:id])
    @subjects = Subject.all()
    @studies = @teacher.teacher_profile_studies
    @works = @teacher.teacher_profile_works

    @teacher.build_location if @teacher.location.blank?
  end

  def update
    @teacher = User.find(params[:id])

    @teacher.location.try(:destroy) unless params[:location][:name].present?

    if @teacher.update(user_params)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      redirect_to root_path
    else
      @subjects = Subject.all()
      @studies = @teacher.teacher_profile_studies
      @works = @teacher.teacher_profile_works
      render :show
    end
  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
  end

  def new
    @teacher_profile = current_user.build_teacher_profile
    @subjects = Subject.all()
  end

  def create
    if current_user.create_teacher_profile(params.require(:teacher_profile).permit(:description, :hour_rate, :subject_ids => [])).valid?
      current_user.add_role(:teacher)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      redirect_to root_path
    else
      @teacher_profile = current_user.teacher_profile
      render :new
    end
  end

  def upload_avatar
    @teacher = current_user
    @teacher.avatar = params[:avatar]
    @teacher.save!

    redirect_to teacher_path(@teacher)
  end

  private

  def user_params
    params_ret = params.require(:user).permit(:first_name, :last_name, location_attributes: [:id, :lat, :lng, :full_address], teacher_profile_attributes: [:description, :id, :hour_rate, subject_ids: [], works_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy], studies_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy]])
    params[:location][:name].blank? ? params_ret.except(:location_attributes) : params_ret
  end
end
