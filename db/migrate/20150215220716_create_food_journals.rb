class CreateFoodJournals < ActiveRecord::Migration
  def change
    create_table :food_journals do |t|
      t.text :food
      t.integer :qty
      t.integer :cals
      t.integer :fat
      t.integer :carbs
      t.integer :protein

      t.timestamps null: false
    end
  end
end
