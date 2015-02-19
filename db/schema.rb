# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150219155109) do

  create_table "food_journals", force: :cascade do |t|
    t.text     "food"
    t.integer  "qty"
    t.integer  "cals"
    t.integer  "fat"
    t.integer  "carbs"
    t.integer  "protein"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.datetime "date"
  end

  create_table "users", force: :cascade do |t|
    t.text     "handle"
    t.text     "password"
    t.text     "email"
    t.boolean  "male"
    t.integer  "age"
    t.integer  "weight"
    t.integer  "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "target"
    t.integer  "goal"
    t.integer  "height"
  end

end
