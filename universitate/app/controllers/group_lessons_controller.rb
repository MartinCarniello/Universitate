class GroupLessonsController < ApplicationController

  def index
    @lessons = GroupLesson.all()
    @lessons = @lessons.all_except(current_user) 
    @lessons = @lessons.page(params[:page])
    @my_lessons = GroupLesson.my_lessons(current_user)
  end

  def create
    @group_lesson = GroupLesson.create(group_lesson_required_params)
    if @group_lesson.save
      redirect_to group_lessons_path
    else
      render :new
    end

  end

  def new
    @teacher = User.find(params[:teacher_id])
    @group_lesson = GroupLesson.new
    @group_lesson.teacher_profile = @teacher.teacher_profile
    @subjects = Subject.all()
  end

  def group_lesson_required_params
    case params[:action]
    when 'create'
      params.require(:group_lesson).permit(:teacher_profile_id, :day_and_hour, :subject_id)
    when 'update'
      params.require(:group_lesson).permit(:user_id, :day_and_hour, :subject_id)
    else
    end
  end
end
