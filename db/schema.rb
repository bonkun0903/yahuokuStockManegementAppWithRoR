# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_01_050108) do

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "category", default: 0, null: false
    t.string "title", default: "", null: false
    t.text "description", null: false
    t.integer "start_price", default: 10000, null: false
    t.integer "count", default: 1, null: false
    t.integer "period", default: 5, null: false
    t.integer "end_time", default: 13, null: false
    t.integer "prefecture_id", default: 33, null: false
    t.integer "shipping_fee_defrayer", default: 0, null: false
    t.integer "payment_timing", default: 0, null: false
    t.integer "fee", default: 0, null: false
    t.integer "product_status", default: 3, null: false
    t.boolean "returnable", default: false, null: false
    t.text "return_remark", null: false
    t.json "image", null: false
    t.boolean "automatic_extension", default: true, null: false
    t.integer "buyout_price", default: 0, null: false
    t.integer "automatic_relist", default: 3, null: false
    t.integer "automatic_price_cut", default: 0, null: false
    t.integer "delivery_method", default: 0, null: false
    t.integer "inventory_status", default: 0, null: false
    t.boolean "zip_exported", default: false, null: false
    t.boolean "inventory_seal_exported", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shelf_id"
    t.index ["shelf_id"], name: "index_products_on_shelf_id"
  end

  create_table "shelves", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "shelf_code", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "body"
    t.boolean "done", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "products", "shelves"
end
