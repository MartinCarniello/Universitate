class CreateTeacherExperiences < ActiveRecord::Migration[5.0]
  def self.up
    create_table :teacher_experiences do |t|
      t.integer :teacher_profile_id, index: true
      t.string :name_of_the_place
      t.datetime :period_start
      t.datetime :period_end
      t.string :description
      t.integer :experience_type
      end
    end

    def self.down
      drop_table :teacher_experiences
    end
end
