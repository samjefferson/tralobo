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

ActiveRecord::Schema.define(version: 20151211154952) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "log_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["log_id", "created_at"], name: "index_comments_on_log_id_and_created_at"
  add_index "comments", ["log_id"], name: "index_comments_on_log_id"
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.integer  "continent"
    t.integer  "state"
    t.string   "city"
    t.string   "coordinate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["city"], name: "index_locations_on_city", unique: true

  create_table "logs", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "title"
    t.integer  "cached_votes_total", default: 0
    t.integer  "cached_votes_score", default: 0
  end

  add_index "logs", ["cached_votes_score"], name: "index_logs_on_cached_votes_score"
  add_index "logs", ["location_id", "created_at"], name: "index_logs_on_location_id_and_created_at"
  add_index "logs", ["location_id"], name: "index_logs_on_location_id"
  add_index "logs", ["user_id", "created_at"], name: "index_logs_on_user_id_and_created_at"
  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
