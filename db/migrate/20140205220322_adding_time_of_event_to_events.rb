class AddingTimeOfEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time_of_event, :datetime
  end
end
