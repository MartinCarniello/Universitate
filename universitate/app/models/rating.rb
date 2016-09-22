# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  teacher_profile_id :integer
#  value              :integer
#  comment            :string
#  reply              :string
#

class Rating < ApplicationRecord
  belongs_to :teacher_profile
  
end
