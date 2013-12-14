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

ActiveRecord::Schema.define(version: 20131214150411) do

  create_table "answers", force: true do |t|
    t.string   "chosen_name"
    t.string   "content"
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.integer  "code"
    t.boolean  "cc"
    t.boolean  "tc"
    t.boolean  "ty"
    t.string   "structure"
    t.string   "bushou"
    t.integer  "bihua"
    t.integer  "zongbihua"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["bushou", "bihua"], name: "index_characters_on_bushou_and_bihua"
  add_index "characters", ["bushou"], name: "index_characters_on_bushou"
  add_index "characters", ["code"], name: "index_characters_on_code", unique: true
  add_index "characters", ["structure"], name: "index_characters_on_structure"
  add_index "characters", ["zongbihua"], name: "index_characters_on_zongbihua"

  create_table "histories", force: true do |t|
    t.string   "content"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "content"
    t.string   "time_stamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_user"
    t.integer  "user_id"
    t.integer  "order_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "num_answers",       default: 0
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_user_message",  default: false
    t.boolean  "new_admin_message", default: false
  end

  add_index "orders", ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"

  create_table "product_attribute_values", force: true do |t|
    t.integer  "product_attribute_id"
    t.integer  "order_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value_set"
  end

  add_index "product_attribute_values", ["order_id"], name: "index_product_attribute_values_on_order_id"

  create_table "product_attributes", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "attr_type"
    t.text     "params",         default: "{label: false}"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "requirement"
    t.string   "error_messages"
    t.boolean  "multiple",       default: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
