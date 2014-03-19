class ChangeLatAndLongToFloat < ActiveRecord::Migration
  def change
    remove_column :events, :lat
    remove_column :events, :long
    add_column :events, :lat, :float
    add_column :events, :long, :float
  end
end
