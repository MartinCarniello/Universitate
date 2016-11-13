class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @params = params
    @search = UserSearch.new(search_params)
    @teachers = @search.results
    @teachers = @teachers.except_user(current_user) if user_signed_in?
    @teachers = @teachers.page(params[:page])
  end

  def show
    @tab = params[:tab] || 'profile'
    @page = params[:page] || 1
    @user = User.find(params[:id])
    @subjects = Subject.all
    @studies = @user.teacher_profile_studies
    @works = @user.teacher_profile_works

    @user.build_location if @user.location.blank?
    @rating = Rating.new(teacher_profile: @user.teacher_profile)
  end

  def new
    @user = current_user
    @teacher_profile = @user.build_teacher_profile
    @user.build_location if @user.location.blank?
    @subjects = Subject.all
  end

  def create
    if current_user.create_teacher_profile(new_teacher_params).valid?
      current_user.add_role(:teacher)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      redirect_to root_path
    else
      @subjects = Subject.all
      @teacher_profile = current_user.teacher_profile
      render :new
    end
  end

  def update
    @user = current_user

    @user.location.try(:destroy) unless params[:location][:name].present?

    if @user.update_attributes(teacher_params)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      @tab = 'profile'
      redirect_to teacher_path(@user)
    else
      @subjects = Subject.all
      @studies = @user.teacher_profile_studies
      @works = @user.teacher_profile_works
      @user.build_location if @user.location.blank?
      @tab = 'edit-profile'
      @page = 1
      render :show
    end
  end

  def upload_avatar
    @teacher = current_user
    @teacher.avatar = params[:avatar]
    @teacher.save!

    redirect_to teacher_path(@teacher)
  end

  def new_rating
    @teacher = User.find(params[:teacher_id])
    @rating = Rating.new
    @rating.user = current_user
    @rating.teacher_profile = @teacher.teacher_profile
  end

  private

  def new_teacher_params
    params.require(:teacher_profile).permit(:description, :hour_rate, :subject_ids => [])
  end

  def teacher_params
    params_ret = params.require(:user).permit(:first_name, :last_name, location_attributes: [:id, :lat, :lng, :full_address], teacher_profile_attributes: [:description, :id, :hour_rate, :type_of_service_cd, :level_cd, subject_ids: [], works_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy], studies_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy]])
    params[:location][:name].blank? ? params_ret.except(:location_attributes) : params_ret
  end

  def search_params
    @search_params ||= params.delete(:user_search) || {}
    @search_params.merge!(rating_sort_desc: 'on') if @search_params[:sort_method] == 'rating_sort_desc'
    @search_params.merge!(location_sort_asc: {}) unless @search_params[:sort_method] == 'location_sort_asc'
    @search_params
  end
end
