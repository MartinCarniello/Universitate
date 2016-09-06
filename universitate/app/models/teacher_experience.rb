class TeacherExperience < ApplicationRecord
  belongs_to :teacher_profile
  enum experience_type: [:study, :work]

end
