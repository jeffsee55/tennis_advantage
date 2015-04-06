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

ActiveRecord::Schema.define(version: 20150406021655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "qty"
    t.integer  "order_id"
    t.string   "session_id"
    t.integer  "total_cents",    default: 0,     null: false
    t.string   "total_currency", default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
  end

  create_table "order_events", force: true do |t|
    t.integer  "order_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.float    "total"
    t.string   "stripe_customer_id"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.string   "street1"
    t.string   "street2"
    t.string   "shipment_id"
    t.string   "name"
    t.string   "charge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weight"
    t.float    "height"
    t.float    "length"
    t.float    "width"
    t.string   "email"
    t.boolean  "hand_deliver"
    t.string   "country"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content_a"
    t.text     "content_b"
    t.text     "content_c"
    t.text     "content_d"
    t.text     "content_f"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_e"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_1_id"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_1_id"
    t.string   "image_2_id"
    t.string   "image_3_id"
    t.string   "image_4_id"
    t.integer  "inventory",      default: 12
    t.text     "description"
    t.string   "category"
  end

  create_table "program_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_1_id"
    t.string   "category",    default: "Lessons"
  end

  create_table "slide_images", force: true do |t|
    t.string   "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slideshows", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "name"
    t.string   "phone"
    t.string   "bio"
    t.string   "image_1_id"
    t.boolean  "contactable"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
