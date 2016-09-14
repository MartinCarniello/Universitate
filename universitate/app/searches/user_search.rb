require "searchlight/adapters/action_view"

class UserSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    User.all
  end

  def search_complete_name_like
    query.with_display_name(options[:complete_name_like])
  end

  def search_subject_eq
    query.with_subjects(options[:subject_eq])
  end

end
