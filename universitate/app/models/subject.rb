# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ApplicationRecord
  has_and_belongs_to_many :teacher_profiles
end
