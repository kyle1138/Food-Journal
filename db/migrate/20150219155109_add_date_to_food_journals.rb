class AddDateToFoodJournals < ActiveRecord::Migration
  def change
    add_column :food_journals, :date, :datetime
  end
end
