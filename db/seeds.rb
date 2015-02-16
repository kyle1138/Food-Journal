# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
# create_table "food_journals", force: :cascade do |t|
#   t.text     "food"
#   t.integer  "qty"
#   t.integer  "cals"
#   t.integer  "fat"
#   t.integer  "carbs"
#   t.integer  "protein"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer  "user_id"
# end
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(handle: "alison" , password: "poop", email: "kyle1980@gmail.com", male: false , weight: 115)


FoodJournal.create(food: "butter" , qty: 100, cals: 500, fat: 50, carbs: 5, protein: 5, user_id: 1)
FoodJournal.create(food: "bread" , qty: 50, cals: 200, fat: 5, carbs: 45, protein: 9, user_id: 1)
FoodJournal.create(food: "carrots" , qty: 100, cals: 100, fat: 0, carbs: 24, protein: 1, user_id: 1)
