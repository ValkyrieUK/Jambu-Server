class AddingNotifiedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :notified, :boolean
    add_column :events, :privacy, :string
    add_column :events, :location_name, :string
  end
end
