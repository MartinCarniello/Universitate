class RatingsController < ApplicationController
  def index
    @teacher = User.find(params[:teacher_id])
    @page = params[:page]
    @ratings = @teacher.ratings.recents.page(@page)
    type, message = @ratings.empty? ? [:danger, I18n.t('views.teacher_profile.rating.load_failed')] : [:notice, I18n.t('views.teacher_profile.rating.load_success')]
    flash.now[type] = message
  end

  def create
    @rating = Rating.create(rating_required_params)
    @user = TeacherProfile.find(@rating.teacher_profile_id).user
    UserMailer.rating_email(@user).deliver if @rating.valid?
    flash.now[:notice] = I18n.t('views.teacher_profile.rating.create_success')
  end

  def update
    @rating = Rating.find(params[:rating][:id])
    @rating.update_attributes(rating_required_params)
    flash.now[:notice] = I18n.t('views.teacher_profile.rating.update_success')
  end

  private

  def rating_required_params
    case params[:action]
    when 'create'
      params.require(:rating).permit(:comment, :value, :user_id, :teacher_profile_id)
    when 'update'
      params.require(:rating).permit(:reply)
    else
    end
  end
end
