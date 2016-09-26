class RatingsController < ApplicationController
  def create
    @rating = Rating.create(rating_required_params)
  end

  def rating_required_params
    params.require(:rating).permit(:comment, :value, :user_id, :teacher_profile_id)
  end
end
