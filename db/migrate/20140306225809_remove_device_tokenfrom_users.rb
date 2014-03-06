class RemoveDeviceTokenfromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :device_token
  end
end
