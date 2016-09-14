# == Schema Information
#
# Table name: teacher_experiences
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  name_of_the_place  :string
#  period_start       :datetime
#  period_end         :datetime
#  description        :string
#  experience_type    :integer
#

class TeacherExperience < ApplicationRecord
  belongs_to :teacher_profile
  enum experience_type: [:STUDY, :WORK]

end
