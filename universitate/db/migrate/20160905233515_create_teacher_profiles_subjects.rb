class CreateTeacherProfilesSubjects < ActiveRecord::Migration[5.0]
  def self.up
    remove_column :teacher_profiles, :subjects

    create_table :subjects_teacher_profiles, id: false do |t|
      t.integer :subject_id, index: true
      t.integer :teacher_profile_id, index: true
    end
  end

  def self.down
    add_column :teacher_profiles, :subjects, :string
    drop_table :subjects_teacher_profiles
  end
end
