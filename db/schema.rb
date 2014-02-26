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

ActiveRecord::Schema.define(version: 20140226185114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "yelp_business_id"
  end

  add_index "brands", ["yelp_business_id"], name: "index_brands_on_yelp_business_id", using: :btree

  create_table "truck_posts", force: true do |t|
    t.integer  "day_of_week",                         null: false
    t.time     "start_time",                          null: false
    t.time     "end_time",                            null: false
    t.decimal  "latitude",    precision: 9, scale: 6
    t.decimal  "longitude",   precision: 9, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "truck_id"
  end

  add_index "truck_posts", ["day_of_week", "start_time", "end_time"], name: "index_truck_posts_on_day_of_week_and_start_time_and_end_time", using: :btree
  add_index "truck_posts", ["day_of_week"], name: "index_truck_posts_on_day_of_week", using: :btree
  add_index "truck_posts", ["truck_id"], name: "index_truck_posts_on_truck_id", using: :btree

  create_table "trucks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
  end

  add_index "trucks", ["brand_id"], name: "index_trucks_on_brand_id", using: :btree

end
