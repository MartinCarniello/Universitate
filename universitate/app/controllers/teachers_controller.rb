class TeachersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @search = UserSearch.new(search_params)
    @teachers = @search.results.with_role(:teacher)
    @teachers = @teachers.except_user(current_user) if user_signed_in?
  end

  def show
    @tab = params[:tab] || 'profile'
    @user = User.find(params[:id])
    @subjects = Subject.all()
    @studies = @user.teacher_profile_studies
    @works = @user.teacher_profile_works

    @user.build_location if @user.location.blank?
    @rating = Rating.new(teacher_profile: @user.teacher_profile)
  end

  def update
    @user = User.find(params[:id])

    @user.location.try(:destroy) unless params[:location][:name].present?

    if @user.update_attributes(user_params)
      flash[:notice] = I18n.t('views.teacher_profile.edit.updated_successfuly')
      @tab = 'profile'
      redirect_to teacher_path(@user)
    else
      @subjects = Subject.all()
      @studies = @user.teacher_profile_studies
      @works = @user.teacher_profile_works
      @user.build_location if @user.location.blank?
      @tab = 'edit-profile'
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

  def new_rating
    @teacher = User.find(params[:teacher_id])
    @rating = Rating.new
    @rating.user = current_user
    @rating.teacher_profile = @teacher.teacher_profile
  end

  private

  def user_params
    params_ret = params.require(:user).permit(:first_name, :last_name, location_attributes: [:id, :lat, :lng, :full_address], teacher_profile_attributes: [:description, :id, :hour_rate, subject_ids: [], works_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy], studies_attributes: [:name_of_the_place, :period_start, :period_end, :description, :id, :_destroy]])
    params[:location][:name].blank? ? params_ret.except(:location_attributes) : params_ret
  end
end
