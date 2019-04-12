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

ActiveRecord::Schema.define(version: 2019_04_12_142656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
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

  create_table "blobs", force: :cascade do |t|
    t.serial "active_storage_blob_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "container_id", null: false
    t.boolean "protected", default: false
    t.string "title"
    t.string "filename", null: false
    t.index ["active_storage_blob_id"], name: "index_blobs_on_active_storage_blob_id", unique: true
    t.index ["container_id"], name: "index_blobs_on_container_id"
    t.index ["filename", "container_id"], name: "index_blobs_on_filename_and_container_id", unique: true
  end

  create_table "containers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tag_id"
    t.bigint "group_id"
    t.bigint "user_id"
    t.index ["group_id"], name: "index_containers_on_group_id"
    t.index ["tag_id", "group_id"], name: "index_containers_on_tag_id_and_group_id", unique: true
    t.index ["tag_id", "user_id"], name: "index_containers_on_tag_id_and_user_id", unique: true
    t.index ["tag_id"], name: "index_containers_on_tag_id"
    t.index ["user_id"], name: "index_containers_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "restricted", default: false
    t.integer "max_size"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "global_admin"
    t.bigint "default_group_id"
    t.integer "upload_limit"
    t.index ["default_group_id"], name: "index_users_on_default_group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blobs", "active_storage_blobs"
  add_foreign_key "blobs", "containers"
  add_foreign_key "containers", "groups"
  add_foreign_key "containers", "tags"
  add_foreign_key "containers", "users"
  add_foreign_key "users", "groups", column: "default_group_id"
end
