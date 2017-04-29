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

ActiveRecord::Schema.define(version: 3) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_examples", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.string   "slug",                               null: false
    t.string   "git"
    t.string   "name"
    t.string   "description"
    t.text     "content"
    t.jsonb    "exloc_metadata",      default: "{}", null: false
    t.jsonb    "repository_metadata", default: "{}", null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["slug"], name: "index_code_examples_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_code_examples_on_user_id", using: :btree
  end

  create_table "file_objects", force: :cascade do |t|
    t.integer "code_example_id",                  null: false
    t.string  "name",                             null: false
    t.integer "size",            default: 0,      null: false
    t.string  "file_type",       default: "file", null: false
    t.string  "url"
    t.index ["code_example_id"], name: "index_file_objects_on_code_example_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",                    null: false
    t.string   "uid",                         null: false
    t.string   "role",       default: "user", null: false
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "image"
    t.string   "location"
    t.jsonb    "urls",       default: "[]",   null: false
    t.string   "token",                       null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
    t.index ["token"], name: "index_users_on_token", unique: true, using: :btree
  end

end
