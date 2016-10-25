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

  def search_location_sort_asc
    options[:sort_method] == 'location_sort_asc' ? query.order_by_distance(options[:location_sort_asc][:lat], options[:location_sort_asc][:lng]) : query
  end

  def search_rating_sort_desc
    options[:sort_method] == 'rating_sort_desc' ? query.best_rated : query
  end

  def search_rate_less_than
    query.joins(:teacher_profile).where('hour_rate <= ?', options[:rate_less_than].to_f)
  end

end
