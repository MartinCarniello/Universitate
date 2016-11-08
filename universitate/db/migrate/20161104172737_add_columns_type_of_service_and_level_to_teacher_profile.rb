class AddColumnsTypeOfServiceAndLevelToTeacherProfile < ActiveRecord::Migration[5.0]
  def self.up
    add_column :teacher_profiles, :type_of_service_cd,:integer
    add_column :teacher_profiles, :level_cd,:integer
  end

  def self.down
    remove_column :teacher_profiles, :type_of_service_cd
    remove_column :teacher_profiles, :level_cd
  end
end
