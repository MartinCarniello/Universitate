class CreateRatings < ActiveRecord::Migration[5.0]
  def self.up
    create_table :ratings do |t|
      t.integer :teacher_profile_id, index: true
      t.integer :value
      t.integer :comment_id
    end
  end

  def self.down
    drop_table :ratings
  end

end
