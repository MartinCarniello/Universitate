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

require 'test_helper'

class TeacherExperienceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
