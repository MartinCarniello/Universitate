class GroupLessonsController < ApplicationController

  def index
    @search = GroupLessonSearch.new(search_params)
    @lessons = @search.results
    @lessons = @lessons.all_except(current_user)
    @lessons = @lessons.non_expired
    @my_lessons = GroupLesson.my_lessons(current_user)
    @my_lessons = @my_lessons.non_expired
    @tab = params[:tab] || 'lessons'
  end

  def show
    @group_lesson = current_user.teacher_profile.group_lessons.non_expired.find(params[:id])

    respond_to do |format|
      format.js
    end
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
    @group_lesson = current_user.teacher_profile.group_lessons.find(params[:id])

    if @group_lesson.update_attributes(group_lesson_required_params)
      flash.now[:notice] = I18n.t('views.group_lessons.edit.update_success')
      notify_students(@group_lesson)
    else
      @subjects = Subject.all
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @group_lesson = current_user.teacher_profile.group_lessons.find(params[:id])
    @group_lesson.delete
    flash.now[:notice] = I18n.t('views.group_lessons.edit.destroyed')

    respond_to do |format|
      format.js
    end
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

  private

  def group_lesson_required_params
    case params[:action]
    when 'create'
      params.require(:group_lesson).permit(:teacher_profile_id, :day_and_hour, :subject_id)
    when 'update'
      params.require(:group_lesson).permit(:user_id, :day_and_hour, :subject_id)
    else
    end
  end

  def search_params
    @search_params ||= params.delete(:group_lesson_search) || {}
    @search_params.merge!(current_user_id: current_user.id)
    @search_params
  end

  def notify_students(lesson)
    lesson.students.each do |stu|
      UserMailer.group_lesson_modified(stu, lesson)
    end
  end
end
