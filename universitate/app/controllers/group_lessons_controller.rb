class GroupLessonsController < ApplicationController

  def index
    @search = GroupLessonSearch.new(search_params)
    @lessons = @search.results
    @lessons = @lessons.all_except(current_user)
    @my_lessons = GroupLesson.my_lessons(current_user)
    @tab = params[:tab] || 'lessons'
  end

  def new
    @teacher = current_user
    @group_lesson = GroupLesson.new
    @group_lesson.teacher_profile = @teacher.teacher_profile
    @subjects = Subject.all

    respond_to do |format|
      format.js { render :lesson_form }
    end
  end

  def create
    @group_lesson = GroupLesson.create(group_lesson_required_params.merge(teacher_profile_id: current_user.teacher_profile.id))

    @group_lesson.save ? flash.now[:notice] = I18n.t('views.group_lessons.new.success') : @subjects = Subject.all

    respond_to do |format|
      format.js
    end
  end

  def update
    @group_lesson = GroupLesson.find(params[:id])

    if @group_lesson.update_attributes(group_lesson_required_params)
      flash.now[:notice] = I18n.t('views.group_lessons.edit.update_success')
      # FIXME: Descomentar cuando se arregle el mailer
      # notify_students(@group_lesson)
    else
      @subjects = Subject.all
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @lesson = GroupLesson.find(params[:id])
    @lesson.delete
    flash[:success] = I18n.t('es.views.group_lessons.edit.destroyed')
    @tab = 'my_lessons'
    @search = GroupLessonSearch.new(search_params)
    @lessons = GroupLesson.all_except(current_user)
    @my_lessons = GroupLesson.my_lessons(current_user)
    render :index
  end

  def update_lesson
    @group_lesson = GroupLesson.find(params[:id])
    @subjects = Subject.all

    respond_to do |format|
      format.js { render :lesson_form }
    end
  end

  def attend
    @lesson = GroupLesson.find(params[:group_lesson_id])
    @lesson.students << current_user

    @lesson.save ? flash.now[:notice] = I18n.t('views.group_lessons.index.add_success') : flash.now[:error] = I18n.t('views.group_lessons.index.add_failed')

    respond_to do |format|
      format.js
    end
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

  private

  def search_params
    @search_params ||= params.delete(:group_lesson_search) || {}
  end

  def notify_students(lesson)
    lesson.students.each  do |stu|
      UserMailer.group_lesson_modified(stu,lesson)
    end
  end
end
