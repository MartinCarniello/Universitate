class CreateTeacherProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_profiles do |t|
      t.string :description
      t.string 'subjects', array: true
      t.integer :user_id
    end

    add_index :teacher_profiles, :subjects, using: 'gin'
  end
end
