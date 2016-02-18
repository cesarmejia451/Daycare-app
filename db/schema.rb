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

ActiveRecord::Schema.define(version: 20160217215051) do

  create_table "center_programs", force: :cascade do |t|
    t.integer  "center_id",  limit: 4
    t.integer  "program_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "centers", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "website",      limit: 255
    t.string   "zip_code",     limit: 255
    t.string   "phone",        limit: 255
    t.text     "description",  limit: 65535
    t.string   "hours",        limit: 255
    t.string   "rates",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lat",          limit: 255
    t.string   "long",         limit: 255
    t.string   "neighborhood", limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "field",      limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
  end

  create_table "images", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.integer  "center_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posted_tags", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
    t.integer  "center_id",   limit: 4
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
