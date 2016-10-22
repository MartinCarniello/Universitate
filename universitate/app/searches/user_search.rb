require "searchlight/adapters/action_view"

class UserSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  attr_accessor :lat, :lng, :full_address

  def base_query
    User.teachers
  end

  def search_complete_name_like
    query.with_display_name(options[:complete_name_like])
  end

  def search_subject_eq
    query.with_subjects(options[:subject_eq])
  end

  def location_sort_asc

  end

  def search_rating_sort_desc
    options[:rating_sort_desc] == 'on' ? query.best_rated : query
  end

end
