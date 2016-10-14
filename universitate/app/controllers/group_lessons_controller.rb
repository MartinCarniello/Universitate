class GroupLessonsController < ApplicationController

  def index
    @search = GroupLessonSearch.new(search_params)
    @lessons = GroupLesson.all()
    @lessons = @lessons.all_except(current_user)
    @lessons = @lessons.page(params[:page])
    @my_lessons = GroupLesson.my_lessons(current_user)
  end

  def create
    @group_lesson = GroupLesson.create(group_lesson_required_params)
    @subjects = Subject.all()
    if @group_lesson.save
      redirect_to group_lessons_path
    else
      render :new , subjects: @subjects
    end
  end

  def search_params
    @search_params ||= params.delete(:group_lesson_search) || {}
  end

  def update
    @lesson = GroupLesson.find(params[:id])
    binding.pry
    if @lesson.teacher_profile == current_user.teacher_profile
      @lesson.update_attributes(group_lesson_required_params)
      flash.now[:notice] = I18n.t('views.group_lessons.edit.update_success')
      redirect_to group_lessons_path
    else
      @lesson.students << current_user
      if @lesson.save
        flash.now[:notice] = I18n.t('views.group_lessons.index.add_success')
        redirect_to group_lessons_path
      else
        render group_lessons_path
      end
    end
  end

  def new
    @teacher = User.find(params[:teacher_id])
    @group_lesson = GroupLesson.new
    @group_lesson.teacher_profile = @teacher.teacher_profile
    @subjects = Subject.all()
  end

  def destroy
      @lesson = GroupLesson.find(params[:id])

      @lesson.delete

      flash[:success] = I18n.t('es.views.group_lessons.index.destroyed')

      redirect_to group_lessons_path
  end


  def update_lesson
    @lesson = GroupLesson.find(params[:id])
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
