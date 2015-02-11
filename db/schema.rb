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

ActiveRecord::Schema.define(version: 20150211023920) do

  create_table "applies", force: true do |t|
    t.integer  "apply_type"
    t.integer  "amount"
    t.integer  "obj_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applies", ["obj_id"], name: "index_applies_on_obj_id"

  create_table "area_strings", force: true do |t|
    t.integer  "vnum"
    t.string   "message_to_pc"
    t.string   "message_to_room"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "area_strings", ["area_id"], name: "index_area_strings_on_area_id"

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
    t.integer  "misc_flags"
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
    t.integer  "reset"
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

  create_table "mobiles", force: true do |t|
    t.integer  "vnum"
    t.string   "keywords"
    t.string   "sdesc"
    t.string   "ldesc"
    t.text     "look_desc"
    t.integer  "act_flags"
    t.integer  "affect_flags"
    t.integer  "alignment"
    t.integer  "level"
    t.integer  "sex"
    t.integer  "langs_known"
    t.integer  "lang_spoken"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spell"
  end

  add_index "mobiles", ["area_id"], name: "index_mobiles_on_area_id"

  create_table "objs", force: true do |t|
    t.integer  "area_id"
    t.integer  "vnum"
    t.string   "keywords"
    t.string   "sdesc"
    t.string   "ldesc"
    t.integer  "object_type"
    t.integer  "v0"
    t.integer  "v1"
    t.integer  "v2"
    t.integer  "v3"
    t.integer  "extra_flags"
    t.integer  "wear_flags"
    t.integer  "weight"
    t.integer  "cost"
    t.integer  "misc_flags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "objs", ["area_id"], name: "index_objs_on_area_id"

  create_table "oxdescs", force: true do |t|
    t.string   "keywords"
    t.text     "description"
    t.integer  "obj_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oxdescs", ["obj_id"], name: "index_oxdescs_on_obj_id"

  create_table "resets", force: true do |t|
    t.string   "reset_type"
    t.integer  "val_1"
    t.integer  "val_2"
    t.integer  "val_3"
    t.integer  "val_4"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resets", ["area_id"], name: "index_resets_on_area_id"

  create_table "room_specials", force: true do |t|
    t.string   "room_special_type"
    t.string   "name"
    t.integer  "extended_value_1"
    t.integer  "extended_value_2"
    t.integer  "extended_value_3"
    t.integer  "extended_value_4"
    t.integer  "extended_value_5"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "room_specials", ["room_id"], name: "index_room_specials_on_room_id"

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

  create_table "rspecs", force: true do |t|
    t.string   "rspec_type"
    t.string   "name"
    t.integer  "extended_value_1"
    t.integer  "extended_value_2"
    t.integer  "extended_value_3"
    t.integer  "extended_value_4"
    t.integer  "extended_value_5"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rspecs", ["room_id"], name: "index_rspecs_on_room_id"

  create_table "rxdescs", force: true do |t|
    t.string   "keywords"
    t.text     "description"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rxdescs", ["room_id"], name: "index_rxdescs_on_room_id"

  create_table "shares", force: true do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["area_id"], name: "index_shares_on_area_id"

  create_table "shops", force: true do |t|
    t.integer  "buy_type_1"
    t.integer  "buy_type_2"
    t.integer  "buy_type_3"
    t.integer  "buy_type_4"
    t.integer  "buy_type_5"
    t.integer  "open_hour"
    t.integer  "close_hour"
    t.integer  "race"
    t.integer  "mobile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["mobile_id"], name: "index_shops_on_mobile_id"

  create_table "specials", force: true do |t|
    t.string   "special_type"
    t.string   "name"
    t.integer  "extended_value_1"
    t.integer  "extended_value_2"
    t.integer  "extended_value_3"
    t.integer  "extended_value_4"
    t.integer  "extended_value_5"
    t.integer  "mobile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specials", ["mobile_id"], name: "index_specials_on_mobile_id"

  create_table "sub_resets", force: true do |t|
    t.string   "reset_type"
    t.integer  "val_1"
    t.integer  "val_2"
    t.integer  "val_3"
    t.integer  "val_4"
    t.integer  "reset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_resets", ["reset_id"], name: "index_sub_resets_on_reset_id"

  create_table "triggers", force: true do |t|
    t.string   "trigger_type"
    t.string   "name"
    t.integer  "extended_value_1"
    t.integer  "extended_value_2"
    t.integer  "extended_value_3"
    t.integer  "extended_value_4"
    t.integer  "extended_value_5"
    t.integer  "exit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "triggers", ["exit_id"], name: "index_triggers_on_exit_id"

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
    t.integer  "roles"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
