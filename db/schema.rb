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

ActiveRecord::Schema.define(version: 20140623105411) do

  create_table "devices", force: true do |t|
    t.string   "user_name"
    t.string   "mongo_id"
    t.string   "uuid"
    t.string   "android_id"
    t.datetime "created_at"
    t.string   "os_version"
    t.string   "model"
    t.string   "product"
    t.string   "manufacturer"
    t.string   "brand"
    t.integer  "user_locations"
    t.integer  "user_activities"
    t.integer  "app_sessions"
    t.datetime "updated_at"
  end

  create_table "user_activities", force: true do |t|
    t.datetime "activity_timestamp"
    t.string   "activity_name"
    t.integer  "activity_type"
    t.integer  "activity_confidence"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_locations", force: true do |t|
    t.datetime "location_timestamp"
    t.integer  "location_elapsed_realtime_nanos"
    t.string   "location_provider"
    t.float    "location_latitude"
    t.float    "location_longitude"
    t.float    "location_altitude"
    t.float    "location_speed"
    t.float    "location_accuracy"
    t.integer  "location_app_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
