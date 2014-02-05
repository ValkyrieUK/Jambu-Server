class RemoveAttendeeId < ActiveRecord::Migration
  def change
    remove_column :attendees, :attendee_id
    add_column :attendees, :user_id, :integer
  end
end
