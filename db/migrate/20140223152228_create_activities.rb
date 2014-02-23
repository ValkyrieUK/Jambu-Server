class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :action
      t.string :name
      t.string :argument
      t.timestamps
    end
  end
end
