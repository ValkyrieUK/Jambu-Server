class AddingFriendUid < ActiveRecord::Migration
  def change
    add_column :friendships, :user_uid, :string
    add_column :friendships, :friend_uid, :string
  end
end
