class CancelEvents < ActiveRecord::Migration
  def change
    add_column :events, :canceled?, :string
  end
end
