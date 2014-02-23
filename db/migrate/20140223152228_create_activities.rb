class CreateActivities < ActiveRecord::Migration
  def change
    drop_table :activities
    create_table :activities do |t|
      t.integer :user_id
      t.string :action
      t.string :argument
      t.timestamps
    end
  end
end
