class ChangeCanceledToSometingElse < ActiveRecord::Migration
  def change
    rename_column :events, :canceled?, :canceled
  end
end
