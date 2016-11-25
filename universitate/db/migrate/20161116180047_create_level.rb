class CreateLevel < ActiveRecord::Migration[5.0]

  def self.up
    remove_column :teacher_profiles, :level_cd
    create_table :levels do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :levels
    add_column :teacher_profiles, :level_cd,:integer
  end
end
