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

ActiveRecord::Schema.define(version: 20150120042901) do

  create_table "areas", force: true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "area_number"
    t.integer  "flags"
    t.integer  "vnum_qty"
    t.integer  "default_terrain"
    t.integer  "default_room_flags"
  end

  add_index "areas", ["user_id"], name: "index_areas_on_user_id"

  create_table "exits", force: true do |t|
    t.integer  "direction"
    t.text     "description"
    t.string   "keywords"
    t.integer  "exittype"
    t.integer  "keyvnum"
    t.integer  "exit_room_id"
    t.string   "name"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exits", ["room_id"], name: "index_exits_on_room_id"

  create_table "helps", force: true do |t|
    t.integer  "min_level"
    t.string   "keywords"
    t.text     "body"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "helps", ["area_id"], name: "index_helps_on_area_id"

  create_table "rooms", force: true do |t|
    t.integer  "vnum"
    t.string   "name"
    t.text     "description"
    t.integer  "room_flags"
    t.integer  "terrain"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["area_id"], name: "index_rooms_on_area_id"

  create_table "rxdescs", force: true do |t|
    t.string   "keywords"
    t.text     "description"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rxdescs", ["room_id"], name: "index_rxdescs_on_room_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
