class AddConfirmationToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :going?, :boolean
  end
end
