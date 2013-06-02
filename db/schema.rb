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

ActiveRecord::Schema.define(version: 20130602133614) do

  create_table "batters", force: true do |t|
    t.string   "name"
    t.integer  "p_id"
    t.integer  "team_id"
    t.float    "avg"
    t.integer  "ab"
    t.integer  "h"
    t.integer  "r"
    t.integer  "rbi"
    t.integer  "single"
    t.integer  "double"
    t.integer  "triple"
    t.integer  "hr"
    t.integer  "bb"
    t.integer  "hbp"
    t.integer  "sb"
    t.integer  "cs"
    t.integer  "so"
    t.integer  "err"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data", force: true do |t|
    t.string   "gid"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "team_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_fetchers", force: true do |t|
    t.string   "gid"
    t.string   "team_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitchers", force: true do |t|
    t.string   "name"
    t.integer  "p_id"
    t.integer  "team_id"
    t.float    "era"
    t.integer  "w"
    t.integer  "l"
    t.float    "whip"
    t.float    "ip"
    t.integer  "h"
    t.integer  "er"
    t.integer  "r"
    t.integer  "bb"
    t.integer  "k"
    t.integer  "sv"
    t.integer  "hbp"
    t.integer  "hra"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "p_id"
    t.string   "name"
    t.string   "bats"
    t.string   "throws"
    t.string   "pos"
    t.integer  "jersey_number"
    t.integer  "team_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.integer  "league_id"
    t.string   "division"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
  end

end
