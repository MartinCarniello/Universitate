require "searchlight/adapters/action_view"

class GroupLessonSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    GroupLesson.all
  end

  def search_subject_eq
    query.with_subjects(options[:subject_eq])
  end

end
