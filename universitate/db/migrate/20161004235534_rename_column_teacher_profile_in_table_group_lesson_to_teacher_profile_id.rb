class RenameColumnTeacherProfileInTableGroupLessonToTeacherProfileId < ActiveRecord::Migration[5.0]
  def self.up
    change_table :group_lessons do |t|
      t.rename :teacher_profile, :teacher_profile_id
      t.rename :user, :user_id
    end
  end

  def self.down
    change_table :group_lessons do |t|
      t.rename :teacher_profile_id, :teacher_profile
      t.rename :user_id, :user
    end
  end
end
