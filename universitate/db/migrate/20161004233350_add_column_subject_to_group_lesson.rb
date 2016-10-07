class AddColumnSubjectToGroupLesson < ActiveRecord::Migration[5.0]
  def self.up
    add_column :group_lessons, :subject_id,:integer
  end

  def self.down
    remove_column :group_lessons, :subject_id
  end
end
