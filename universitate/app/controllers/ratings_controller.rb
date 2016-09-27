class RatingsController < ApplicationController
  def create
    @rating = Rating.create(rating_required_params)
    @user = TeacherProfile.find(@rating.teacher_profile_id).user
    #UserMailer.rating_email(@user).deliver
  end

  def rating_required_params
    params.require(:rating).permit(:comment, :value, :user_id, :teacher_profile_id)
  end
end
