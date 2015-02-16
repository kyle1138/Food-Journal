class AddUserIdToFoodJournals < ActiveRecord::Migration
  def change
    add_column :food_journals, :user_id, :integer
  end
end
