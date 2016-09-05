class AddGeneralInformationToUsers < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :datetime
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :date_of_birth
  end
end
