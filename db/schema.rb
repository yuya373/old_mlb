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

ActiveRecord::Schema.define(version: 20130929104517) do

  create_table "atbats", force: true do |t|
    t.integer  "num"
    t.integer  "b"
    t.integer  "s"
    t.integer  "o"
    t.integer  "start_tfs"
    t.string   "start_tfs_zulu"
    t.integer  "batter_id"
    t.integer  "pitcher_id"
    t.string   "stand"
    t.string   "b_height"
    t.string   "p_throws"
    t.text     "des",            limit: 255
    t.string   "event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "game_id"
    t.string   "game_id_num"
    t.string   "pitcher_name"
    t.string   "batter_name"
    t.string   "batter_team"
    t.string   "pitcher_team"
    t.integer  "inning"
    t.string   "t_b"
  end

  add_index "atbats", ["batter_id"], name: "index_atbats_on_batter_id"
  add_index "atbats", ["batter_name"], name: "index_atbats_on_batter_name"
  add_index "atbats", ["game_id"], name: "index_atbats_on_game_id"
  add_index "atbats", ["game_id_num"], name: "index_atbats_on_game_id_num"
  add_index "atbats", ["pitcher_id"], name: "index_atbats_on_pitcher_id"
  add_index "atbats", ["pitcher_name"], name: "index_atbats_on_pitcher_name"

  create_table "batter_details", force: true do |t|
    t.string   "p_id_ty"
    t.integer  "p_id"
    t.string   "pitch_type"
    t.string   "ab"
    t.float    "avg"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "bb"
    t.integer  "so"
    t.float    "ops"
    t.string   "rating"
    t.string   "sweetness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "p_b"
  end

  create_table "batter_favorites", force: true do |t|
    t.integer  "batter_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batters", force: true do |t|
    t.integer  "p_id"
    t.string   "name"
    t.string   "active_sw"
    t.string   "status_cd"
    t.string   "last_name"
    t.string   "name_display_last_first"
    t.string   "name_display_first_last"
    t.string   "name_display_roster"
    t.string   "bats"
    t.string   "throws"
    t.string   "pos"
    t.integer  "jersey_number"
    t.integer  "year"
    t.integer  "team_id"
    t.string   "team_abbrev"
    t.integer  "league_id"
    t.string   "league"
    t.integer  "league_games"
    t.integer  "h"
    t.integer  "ab"
    t.integer  "tb"
    t.float    "avg"
    t.float    "avg_sort"
    t.float    "slg"
    t.float    "slg_sort"
    t.integer  "a"
    t.integer  "e"
    t.integer  "po"
    t.integer  "g"
    t.integer  "r"
    t.integer  "b2"
    t.integer  "b3"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "sac"
    t.integer  "sf"
    t.integer  "hbp"
    t.integer  "bb"
    t.integer  "ibb"
    t.integer  "so"
    t.integer  "sb"
    t.integer  "cs"
    t.integer  "gidp"
    t.float    "ops"
    t.float    "ops_sort"
    t.float    "obp"
    t.float    "obp_sort"
    t.integer  "np"
    t.integer  "go"
    t.integer  "ao"
    t.integer  "tpa"
    t.integer  "of_a"
    t.integer  "ph_ab"
    t.integer  "ph_h"
    t.integer  "ph_hr"
    t.integer  "ph_rbi"
    t.integer  "last10_ab"
    t.integer  "last10_h"
    t.integer  "last10_hr"
    t.integer  "last10_rbi"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "height"
    t.string   "weight"
    t.string   "dob"
    t.float    "career_avg"
    t.integer  "career_ab"
    t.integer  "career_h"
    t.integer  "career_bb"
    t.integer  "career_so"
    t.integer  "career_r"
    t.integer  "career_sb"
    t.integer  "career_hr"
    t.integer  "career_rbi"
    t.float    "empty_avg"
    t.integer  "empty_ab"
    t.integer  "empty_h"
    t.integer  "empty_bb"
    t.integer  "empty_so"
    t.integer  "empty_r"
    t.integer  "empty_sb"
    t.integer  "empty_hr"
    t.integer  "empty_rbi"
    t.float    "month_avg"
    t.integer  "month_ab"
    t.integer  "month_h"
    t.integer  "month_bb"
    t.integer  "month_so"
    t.integer  "month_r"
    t.integer  "month_sb"
    t.integer  "month_hr"
    t.integer  "month_rbi"
    t.float    "risp_avg"
    t.integer  "risp_ab"
    t.integer  "risp_h"
    t.integer  "risp_bb"
    t.integer  "risp_so"
    t.integer  "risp_r"
    t.integer  "risp_sb"
    t.integer  "risp_hr"
    t.integer  "risp_rbi"
    t.float    "men_on_avg"
    t.integer  "men_on_ab"
    t.integer  "men_on_h"
    t.integer  "men_on_bb"
    t.integer  "men_on_so"
    t.integer  "men_on_r"
    t.integer  "men_on_sb"
    t.integer  "men_on_hr"
    t.integer  "men_on_rbi"
    t.float    "loaded_avg"
    t.integer  "loaded_ab"
    t.integer  "loaded_h"
    t.integer  "loaded_bb"
    t.integer  "loaded_so"
    t.integer  "loaded_r"
    t.integer  "loaded_sb"
    t.integer  "loaded_hr"
    t.integer  "loaded_rbi"
    t.float    "vs_lhp_avg"
    t.integer  "vs_lhp_ab"
    t.integer  "vs_lhp_h"
    t.integer  "vs_lhp_bb"
    t.integer  "vs_lhp_so"
    t.integer  "vs_lhp_r"
    t.integer  "vs_lhp_sb"
    t.integer  "vs_lhp_hr"
    t.integer  "vs_lhp_rbi"
    t.float    "vs_rhp_avg"
    t.integer  "vs_rhp_ab"
    t.integer  "vs_rhp_h"
    t.integer  "vs_rhp_bb"
    t.integer  "vs_rhp_so"
    t.integer  "vs_rhp_r"
    t.integer  "vs_rhp_sb"
    t.integer  "vs_rhp_hr"
    t.integer  "vs_rhp_rbi"
    t.string   "month_des"
    t.float    "career_ops"
    t.float    "month_ops"
    t.float    "empty_ops"
    t.float    "men_on_ops"
    t.float    "risp_ops"
    t.float    "loaded_ops"
    t.float    "vs_lhp_ops"
    t.float    "vs_rhp_ops"
    t.integer  "career_cs"
    t.integer  "month_cs"
    t.integer  "empty_cs"
    t.integer  "risp_cs"
    t.integer  "men_on_cs"
    t.integer  "loaded_cs"
    t.integer  "vs_lhp"
    t.integer  "vs_rhp"
    t.integer  "vs_rhp_cs"
    t.integer  "vs_lhp_cs"
    t.integer  "reg"
    t.float    "woba"
    t.float    "wraa"
    t.float    "wrc"
    t.float    "wrc_plus"
    t.float    "iso"
    t.float    "k_pct"
    t.float    "bb_pct"
    t.float    "babip"
    t.float    "spd"
  end

  add_index "batters", ["p_id"], name: "index_batters_on_p_id"
  add_index "batters", ["team_id"], name: "index_batters_on_team_id"

  create_table "benches", force: true do |t|
    t.string   "game_id"
    t.string   "team"
    t.integer  "p_id"
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

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examples", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "test"
  end

  create_table "favorites", force: true do |t|
    t.integer  "team_id"
    t.integer  "p_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites_tables", force: true do |t|
    t.integer  "team_id"
    t.integer  "p_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_batters", force: true do |t|
    t.string   "game_id"
    t.string   "team_flag"
    t.integer  "team_id"
    t.integer  "p_id"
    t.string   "name"
    t.string   "name_display_first_last"
    t.string   "pos"
    t.integer  "bo"
    t.integer  "ab"
    t.integer  "po"
    t.integer  "r"
    t.integer  "a"
    t.integer  "bb"
    t.integer  "sac"
    t.integer  "t"
    t.integer  "sf"
    t.integer  "h"
    t.integer  "e"
    t.integer  "d"
    t.integer  "hbp"
    t.integer  "so"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "lob"
    t.float    "fldg"
    t.integer  "sb"
    t.integer  "cs"
    t.integer  "s_hr"
    t.integer  "s_rbi"
    t.integer  "s_h"
    t.integer  "s_bb"
    t.integer  "s_r"
    t.integer  "s_so"
    t.float    "avg"
    t.integer  "go"
    t.integer  "ao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gidp"
    t.string   "note"
  end

  add_index "game_batters", ["game_id"], name: "index_game_batters_on_game_id"

  create_table "game_pitchers", force: true do |t|
    t.string   "game_id"
    t.string   "team_flag"
    t.integer  "team_id"
    t.integer  "p_id"
    t.string   "name"
    t.string   "name_display_first_last"
    t.string   "pos"
    t.integer  "out"
    t.integer  "bf"
    t.integer  "er"
    t.integer  "r"
    t.integer  "h"
    t.integer  "so"
    t.integer  "hr"
    t.integer  "bb"
    t.integer  "np"
    t.integer  "s"
    t.integer  "w"
    t.integer  "l"
    t.integer  "sv"
    t.integer  "bs"
    t.integer  "hld"
    t.float    "s_ip"
    t.integer  "s_h"
    t.integer  "s_r"
    t.integer  "s_er"
    t.integer  "s_bb"
    t.integer  "s_so"
    t.float    "era"
    t.string   "win"
    t.string   "loss"
    t.string   "save_"
    t.string   "blown_save"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_pitchers", ["game_id"], name: "index_game_pitchers_on_game_id"

  create_table "games", force: true do |t|
    t.string   "gameday"
    t.string   "home_team_abbrev"
    t.string   "home_team_name_full"
    t.string   "home_team_name"
    t.string   "home_team_name_brief"
    t.integer  "home_w"
    t.integer  "home_l"
    t.integer  "home_league_id"
    t.string   "home_league"
    t.string   "away_team_abbrev"
    t.string   "away_team_name_full"
    t.string   "away_team_name"
    t.string   "away_team_name_brief"
    t.string   "away_w"
    t.string   "away_l"
    t.string   "away_league_id"
    t.string   "away_league"
    t.string   "stadium"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "status"
    t.string   "reason"
    t.datetime "start_time"
  end

  add_index "games", ["gameday"], name: "index_games_on_gameday"
  add_index "games", ["home_team_id", "away_team_id"], name: "index_games_on_home_team_id_and_away_team_id"
  add_index "games", ["year", "month", "day"], name: "index_games_on_year_and_month_and_day"
  add_index "games", ["year", "month"], name: "index_games_on_year_and_month"

  create_table "line_scores", force: true do |t|
    t.string   "game_id"
    t.integer  "inning"
    t.integer  "home"
    t.integer  "away"
    t.integer  "home_team_runs"
    t.integer  "away_team_runs"
    t.integer  "home_team_hits"
    t.integer  "away_team_hits"
    t.integer  "home_team_errors"
    t.integer  "away_team_errors"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wp_id"
    t.string   "wp_name"
    t.integer  "wp_w"
    t.integer  "wp_l"
    t.float    "wp_era"
    t.integer  "lp_id"
    t.string   "lp_name"
    t.integer  "lp_w"
    t.integer  "lp_l"
    t.float    "lp_era"
    t.integer  "sv_id"
    t.string   "sv_name"
    t.integer  "sv_w"
    t.integer  "sv_l"
    t.float    "sv_era"
    t.integer  "sv_sv"
    t.string   "wp_fname"
    t.string   "lp_fname"
    t.string   "wp_lname"
    t.string   "lp_lname"
    t.string   "sv_lname"
    t.string   "sv_fname"
  end

  add_index "line_scores", ["game_id"], name: "index_line_scores_on_game_id"

  create_table "media", force: true do |t|
    t.string   "game_id"
    t.string   "home_team_id"
    t.string   "away_team_id"
    t.string   "media_type"
    t.date     "date",         limit: 255
    t.string   "headline"
    t.string   "duration"
    t.string   "thumb"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sv_id"
    t.integer  "p_id"
    t.integer  "team_id"
    t.text     "des"
  end

  add_index "media", ["game_id"], name: "index_media_on_game_id"
  add_index "media", ["sv_id"], name: "index_media_on_sv_id"

  create_table "pitch_tendencies", force: true do |t|
    t.integer  "p_id"
    t.string   "game_id"
    t.integer  "game_num"
    t.float    "game_vel"
    t.string   "pitch_type"
    t.integer  "num"
    t.float    "movement"
    t.float    "pfx"
    t.float    "vel"
    t.float    "avg_x0"
    t.float    "avg_z0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pitch_tendencies", ["game_id", "p_id", "pitch_type"], name: "index_pitch_tendencies_on_game_id_and_p_id_and_pitch_type"
  add_index "pitch_tendencies", ["game_id"], name: "index_pitch_tendencies_on_game_id"
  add_index "pitch_tendencies", ["p_id"], name: "index_pitch_tendencies_on_p_id"

  create_table "pitch_type_details", force: true do |t|
    t.string   "p_b"
    t.string   "p_id_ty"
    t.integer  "p_id"
    t.string   "pitch_type"
    t.integer  "ab",         limit: 255
    t.float    "avg"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "bb"
    t.integer  "so"
    t.float    "ops"
    t.string   "rating"
    t.string   "sweetness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pitch_type_details", ["p_id", "p_b"], name: "index_pitch_type_details_on_p_id_and_p_b"
  add_index "pitch_type_details", ["p_id"], name: "index_pitch_type_details_on_p_id"
  add_index "pitch_type_details", ["p_id_ty", "p_b"], name: "index_pitch_type_details_on_p_id_ty_and_p_b"

  create_table "pitcher_favorites", force: true do |t|
    t.integer  "pitcher_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitchers", force: true do |t|
    t.integer  "p_id"
    t.string   "name"
    t.string   "active_sw"
    t.string   "status_cd"
    t.string   "last_name"
    t.string   "name_display_last_first"
    t.string   "name_display_first_last"
    t.string   "name_display_roster"
    t.string   "bats"
    t.string   "throws"
    t.string   "pos"
    t.integer  "jersey_number"
    t.integer  "year"
    t.integer  "team_id"
    t.string   "team_abbrev"
    t.integer  "league_id"
    t.string   "league"
    t.integer  "league_games"
    t.integer  "ip"
    t.float    "ip_sort"
    t.integer  "er"
    t.float    "era"
    t.float    "era_sort"
    t.integer  "h"
    t.integer  "r"
    t.integer  "hr"
    t.integer  "hb"
    t.integer  "bb"
    t.integer  "ibb"
    t.integer  "so"
    t.integer  "wp"
    t.float    "avg"
    t.float    "avg_sort"
    t.float    "slg"
    t.float    "slg_sort"
    t.float    "whip"
    t.float    "whip_sort"
    t.float    "pct"
    t.float    "pct_sort"
    t.integer  "ab"
    t.integer  "sf"
    t.integer  "sac"
    t.integer  "gidp"
    t.integer  "p_inh_runner"
    t.integer  "p_inh_runner_scored"
    t.integer  "ao"
    t.integer  "go"
    t.integer  "np"
    t.integer  "bk"
    t.integer  "hld"
    t.integer  "tpa"
    t.integer  "po"
    t.integer  "a"
    t.integer  "e"
    t.integer  "g"
    t.integer  "gs"
    t.integer  "w"
    t.integer  "l"
    t.integer  "cg"
    t.integer  "gf"
    t.integer  "sho"
    t.integer  "sv"
    t.integer  "bsv"
    t.integer  "svo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "height"
    t.string   "weight"
    t.string   "dob"
    t.float    "career_avg"
    t.integer  "career_ab"
    t.integer  "career_h"
    t.integer  "career_bb"
    t.integer  "career_so"
    t.integer  "career_hr"
    t.integer  "career_rbi"
    t.integer  "career_w"
    t.integer  "career_l"
    t.integer  "career_sv"
    t.float    "career_ip"
    t.float    "career_whip"
    t.float    "career_era"
    t.float    "empty_avg"
    t.integer  "empty_ab"
    t.integer  "empty_h"
    t.integer  "empty_bb"
    t.integer  "empty_so"
    t.integer  "empty_sb"
    t.integer  "empty_hr"
    t.integer  "empty_rbi"
    t.integer  "empty_w"
    t.integer  "empty_l"
    t.integer  "empty_sv"
    t.float    "empty_ip"
    t.float    "empty_whip"
    t.float    "empty_era"
    t.string   "month_des"
    t.float    "month_avg"
    t.integer  "month_ab"
    t.integer  "month_h"
    t.integer  "month_bb"
    t.integer  "month_so"
    t.integer  "month_sb"
    t.integer  "month_hr"
    t.integer  "month_rbi"
    t.integer  "month_w"
    t.integer  "month_l"
    t.integer  "month_sv"
    t.float    "month_ip"
    t.float    "month_whip"
    t.float    "month_era"
    t.float    "risp_avg"
    t.integer  "risp_ab"
    t.integer  "risp_h"
    t.integer  "risp_bb"
    t.integer  "risp_so"
    t.integer  "risp_sb"
    t.integer  "risp_hr"
    t.integer  "risp_rbi"
    t.integer  "risp_w"
    t.integer  "risp_l"
    t.integer  "risp_sv"
    t.float    "risp_ip"
    t.float    "risp_whip"
    t.float    "risp_era"
    t.float    "men_on_avg"
    t.integer  "men_on_ab"
    t.integer  "men_on_h"
    t.integer  "men_on_bb"
    t.integer  "men_on_so"
    t.integer  "men_on_sb"
    t.integer  "men_on_hr"
    t.integer  "men_on_rbi"
    t.integer  "men_on_w"
    t.integer  "men_on_l"
    t.integer  "men_on_sv"
    t.float    "men_on_ip"
    t.float    "men_on_whip"
    t.float    "men_on_era"
    t.float    "loaded_avg"
    t.integer  "loaded_ab"
    t.integer  "loaded_h"
    t.integer  "loaded_bb"
    t.integer  "loaded_so"
    t.integer  "loaded_sb"
    t.integer  "loaded_hr"
    t.integer  "loaded_rbi"
    t.integer  "loaded_w"
    t.integer  "loaded_l"
    t.integer  "loaded_sv"
    t.float    "loaded_ip"
    t.float    "loaded_whip"
    t.float    "loaded_era"
    t.float    "vs_lhb_avg"
    t.integer  "vs_lhb_ab"
    t.integer  "vs_lhb_h"
    t.integer  "vs_lhb_bb"
    t.integer  "vs_lhb_so"
    t.integer  "vs_lhb_sb"
    t.integer  "vs_lhb_hr"
    t.integer  "vs_lhb_rbi"
    t.integer  "vs_lhb_w"
    t.integer  "vs_lhb_l"
    t.integer  "vs_lhb_sv"
    t.float    "vs_lhb_ip"
    t.float    "vs_lhb_whip"
    t.float    "vs_lhb_era"
    t.float    "vs_rhb_avg"
    t.integer  "vs_rhb_ab"
    t.integer  "vs_rhb_h"
    t.integer  "vs_rhb_bb"
    t.integer  "vs_rhb_so"
    t.integer  "vs_rhb_sb"
    t.integer  "vs_rhb_hr"
    t.integer  "vs_rhb_rbi"
    t.integer  "vs_rhb_w"
    t.integer  "vs_rhb_l"
    t.integer  "vs_rhb_sv"
    t.float    "vs_rhb_ip"
    t.float    "vs_rhb_whip"
    t.float    "vs_rhb_era"
    t.integer  "reg"
    t.float    "k_pct"
    t.float    "bb_pct"
    t.float    "k_9"
    t.float    "bb_9"
    t.float    "hr_9"
    t.float    "k_bb"
    t.float    "e_f"
    t.float    "fip_minus"
    t.float    "fip"
    t.float    "xfip"
    t.float    "babip"
    t.float    "uera"
    t.float    "rsaa"
    t.float    "dips"
    t.float    "lob_pct"
    t.float    "p_r"
  end

  add_index "pitchers", ["p_id"], name: "index_pitchers_on_p_id"
  add_index "pitchers", ["team_id"], name: "index_pitchers_on_team_id"

# Could not dump table "pitchings" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "team_favorites", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "team_abbrev"
    t.integer  "tb_h"
    t.integer  "tb_ab"
    t.integer  "tb_tb"
    t.float    "tb_avg"
    t.float    "tb_slg"
    t.integer  "tb_g"
    t.integer  "tb_r"
    t.integer  "tb_b2"
    t.integer  "tb_b3"
    t.integer  "tb_hr"
    t.integer  "tb_rbi"
    t.integer  "tb_sac"
    t.integer  "tb_sf"
    t.integer  "tb_hbp"
    t.integer  "tb_bb"
    t.integer  "tb_ibb"
    t.integer  "tb_so"
    t.integer  "tb_sb"
    t.integer  "tb_cs"
    t.integer  "tb_gidp"
    t.float    "tb_obp"
    t.float    "tb_ops"
    t.float    "tp_ip"
    t.integer  "tp_er"
    t.float    "tp_era"
    t.float    "tp_whip"
    t.integer  "tp_h"
    t.integer  "tp_r"
    t.integer  "tp_hr"
    t.integer  "tp_hb"
    t.integer  "tp_bb"
    t.integer  "tp_ibb"
    t.integer  "tp_so"
    t.integer  "tp_wp"
    t.integer  "tp_g"
    t.integer  "tp_gs"
    t.integer  "tp_w"
    t.integer  "tp_l"
    t.integer  "tp_cg"
    t.integer  "tp_gf"
    t.integer  "tp_sho"
    t.integer  "tp_sv"
    t.integer  "tp_bsv"
    t.integer  "tp_svo"
    t.integer  "team_id"
    t.integer  "league_id"
    t.string   "game_id"
    t.float    "win_pct"
    t.string   "division"
    t.float    "lg_era"
    t.integer  "lg_hr"
    t.integer  "lg_bb"
    t.integer  "lg_hb"
    t.integer  "lg_ibb"
    t.integer  "lg_so"
    t.float    "lg_ip"
    t.integer  "lg_er"
    t.float    "lg_fip"
    t.float    "tp_fip"
    t.float    "lg_ra"
    t.float    "lg_woba"
  end

  add_index "teams", ["team_id"], name: "index_teams_on_team_id"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image_url"
    t.string   "email"
    t.string   "access_token"
    t.string   "urls"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
