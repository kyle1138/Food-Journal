class AddGoalAndHeightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal, :integer
    add_column :users, :height, :integer
  end
end
