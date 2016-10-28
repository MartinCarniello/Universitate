# == Schema Information
#
# Table name: group_lessons
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  day_and_hour       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  subject_id         :integer
#

require 'rails_helper'

RSpec.describe GroupLesson, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
