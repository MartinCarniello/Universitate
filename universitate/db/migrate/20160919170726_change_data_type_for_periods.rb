class ChangeDataTypeForPeriods < ActiveRecord::Migration[5.0]
  def self.up
    change_table :teacher_experiences do |t|
      t.change :period_start, :date
      t.change :period_end, :date
    end
  end

  def self.down
    change_table :teacher_experiences do |t|
      t.change :period_start, :datetime
      t.change :period_end, :datetime
    end
  end
end
