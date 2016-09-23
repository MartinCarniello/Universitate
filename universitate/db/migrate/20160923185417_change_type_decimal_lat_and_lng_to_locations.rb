class ChangeTypeDecimalLatAndLngToLocations < ActiveRecord::Migration[5.0]
  def self.up
  	change_column :locations, :lat, :decimal
  	change_column :locations, :lng, :decimal
  end

  def self.down
  	change_column :locations, :lat, :integer
  	change_column :locations, :lng, :integer
  end
end
