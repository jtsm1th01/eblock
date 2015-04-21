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

ActiveRecord::Schema.define(version: 20150421221949) do

  create_table "auctions", force: true do |t|
    t.integer  "charity_id"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "auctions", ["charity_id"], name: "index_auctions_on_charity_id"

  create_table "bids", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "charities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "auction_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["auction_id"], name: "index_items_on_auction_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
