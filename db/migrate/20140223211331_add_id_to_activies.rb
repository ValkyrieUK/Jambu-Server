class AddIdToActivies < ActiveRecord::Migration
  def change
    add_column :activities, :friend_id, :integer
  end
end
