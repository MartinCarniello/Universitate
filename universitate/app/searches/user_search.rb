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

  def search_type_of_service_eq
    query.joins(:teacher_profile).where('teacher_profiles.type_of_service_cd = ? OR teacher_profiles.type_of_service_cd = ?', options[:type_of_service_eq], TeacherProfile.type_of_services[:both])
  end

  def search_level_ids_in
    query.joins(teacher_profile: :levels).where(levels: { id: options[:level_ids_in] }).select('DISTINCT users.*')
  end

end
