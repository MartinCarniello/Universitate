class CreateGroupLessons < ActiveRecord::Migration[5.0]
  def self.up
    create_table :group_lessons do |t|
      t.integer :teacher_profile_id
      t.datetime :day_and_hour

      t.timestamps
    end
  end

  def self.down
    drop_table :group_lessons
  end
end
