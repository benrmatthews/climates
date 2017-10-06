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

ActiveRecord::Schema.define(version: 20140530095202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "support_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["support_id"], name: "index_comments_on_support_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["topic_id"], name: "index_skills_on_topic_id", using: :btree
  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "supports", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receiver_id"
    t.boolean  "done",           default: false
    t.text     "body"
    t.integer  "comments_count", default: 0
  end

  add_index "supports", ["receiver_id"], name: "index_supports_on_receiver_id", using: :btree
  add_index "supports", ["topic_id"], name: "index_supports_on_topic_id", using: :btree
  add_index "supports", ["user_id"], name: "index_supports_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skills_count",   default: 0
    t.integer  "supports_count", default: 0
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skills_count",   default: 0
    t.integer  "supports_count", default: 0
    t.datetime "archived_at"
  end

end
