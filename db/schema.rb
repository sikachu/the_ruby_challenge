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

ActiveRecord::Schema.define(version: 20140917184735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_challenges", force: true do |t|
    t.integer  "submitter_id"
    t.text     "left_code_sample"
    t.text     "right_code_sample"
    t.string   "goal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",              null: false
    t.integer  "left_time_msec"
    t.integer  "right_time_msec"
  end

  add_index "code_challenges", ["slug"], name: "index_code_challenges_on_slug", unique: true, using: :btree
  add_index "code_challenges", ["submitter_id"], name: "index_code_challenges_on_submitter_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "github_user_id",  null: false
    t.string   "github_username", null: false
    t.string   "access_token",    null: false
    t.string   "name"
    t.string   "email"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["github_user_id"], name: "index_users_on_github_user_id", unique: true, using: :btree
  add_index "users", ["github_username"], name: "index_users_on_github_username", unique: true, using: :btree

end
