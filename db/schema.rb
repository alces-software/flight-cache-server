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

ActiveRecord::Schema.define(version: 2019_03_03_185040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_access_tags_on_name", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "blobs", primary_key: "active_storage_blob_id", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "container_id", null: false
    t.index ["container_id"], name: "index_blobs_on_container_id"
  end

  create_table "containers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "access_tag_id"
    t.bigint "group_id", null: false
    t.index ["access_tag_id", "group_id"], name: "index_containers_on_access_tag_id_and_group_id", unique: true
    t.index ["access_tag_id"], name: "index_containers_on_access_tag_id"
    t.index ["group_id"], name: "index_containers_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "global_admin"
    t.bigint "group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  add_foreign_key "blobs", "active_storage_blobs"
  add_foreign_key "blobs", "containers"
  add_foreign_key "containers", "access_tags"
  add_foreign_key "containers", "groups"
  add_foreign_key "users", "groups"
end
