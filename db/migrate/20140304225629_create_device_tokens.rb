class CreateDeviceTokens < ActiveRecord::Migration
  def change
    create_table :device_tokens do |t|
      t.string :token
      t.string :os
      t.integer :user_id
      t.timestamps
    end
  end
end
