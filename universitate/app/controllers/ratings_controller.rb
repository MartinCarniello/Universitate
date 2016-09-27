class RatingsController < ApplicationController
  def create
    @rating = Rating.create(rating_required_params)
  end

  def update
    @rating = Rating.find(params[:rating][:id])
    @rating.update_attributes(rating_required_params)
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
