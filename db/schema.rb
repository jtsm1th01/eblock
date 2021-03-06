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

ActiveRecord::Schema.define(version: 20150605021418) do

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
    t.text     "email"
    t.text     "subhead"
    t.string   "url"
    t.string   "bg_color"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "auction_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "starting_bid"
    t.integer  "bid_increment"
    t.boolean  "approved",           default: false
    t.boolean  "declined",           default: false
    t.string   "name_down"
  end

  add_index "items", ["auction_id"], name: "index_items_on_auction_id"
  add_index "items", ["name_down"], name: "index_items_on_name_down"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "watch_list_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "wants_email", default: false
  end

  add_index "watch_list_items", ["item_id"], name: "index_watch_list_items_on_item_id"
  add_index "watch_list_items", ["user_id"], name: "index_watch_list_items_on_user_id"

  create_table "winning_bids", force: true do |t|
    t.integer "bid_id"
    t.integer "item_id"
    t.boolean "paid",    default: false
  end

  add_index "winning_bids", ["bid_id"], name: "index_winning_bids_on_bid_id"
  add_index "winning_bids", ["item_id"], name: "index_winning_bids_on_item_id"

end
