class CreateTableLevelTeacherProfileRelation < ActiveRecord::Migration[5.0]
  def self.up
    create_table :levels_teacher_profiles, id: false do |t|
      t.belongs_to :teacher_profile, index: true
      t.belongs_to :level, index: true
    end
  end

  def self.down
    drop_table :levels_teacher_profiles
  end

end
