class ChangingTimeOfEventToString < ActiveRecord::Migration
  def change
    remove_column :events, :time_of_event
    add_column :events, :time_of_event, :string
  end
end
