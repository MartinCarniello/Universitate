class CreateTableGroupLessonUserRelation < ActiveRecord::Migration[5.0]
  def self.up
    create_table :group_lessons_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group_lesson, index: true
    end
  end

  def self.down
    drop_table :group_lessons_users
  end
end
