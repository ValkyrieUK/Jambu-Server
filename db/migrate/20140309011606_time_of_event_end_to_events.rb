class TimeOfEventEndToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time_of_event_end, :string
  end
end
