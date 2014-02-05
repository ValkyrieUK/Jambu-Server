class RemovingUidFromFriends < ActiveRecord::Migration
  def change
    remove_column :friendships, :user_uid
    remove_column :friendships, :friend_uid
  end
end
