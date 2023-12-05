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

ActiveRecord::Schema[7.0].define(version: 2023_12_04_055328) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "house_address"
    t.string "phone_number"
    t.string "greeting_name"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "admins", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commodity_id", null: false
    t.integer "customer_id", null: false
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_comments_on_commodity_id"
    t.index ["customer_id"], name: "index_comments_on_customer_id"
  end

  create_table "commodities", force: :cascade do |t|
    t.string "commodity_name"
    t.text "info"
    t.decimal "price"
    t.integer "shop_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seller_id"
    t.integer "count"
    t.integer "image_id"
    t.integer "sales", default: 0
    t.index ["category_id"], name: "index_commodities_on_category_id"
    t.index ["image_id"], name: "index_commodities_on_image_id"
    t.index ["seller_id"], name: "index_commodities_on_seller_id"
    t.index ["shop_id"], name: "index_commodities_on_shop_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cart_id"
    t.index ["cart_id"], name: "index_customers_on_cart_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imageable_type", null: false
    t.integer "imageable_id", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "count"
    t.decimal "price"
    t.boolean "done"
    t.integer "commodity_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cart_id"
    t.integer "address_id"
    t.integer "status", default: 0
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["commodity_id"], name: "index_orders_on_commodity_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sellers_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name"
    t.text "info"
    t.integer "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_shops_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.decimal "balance"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", null: false
    t.string "last_sign_in_ip"
    t.string "current_sign_in_ip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "customers"
  add_foreign_key "admins", "users"
  add_foreign_key "carts", "customers"
  add_foreign_key "comments", "commodities"
  add_foreign_key "comments", "customers"
  add_foreign_key "commodities", "categories"
  add_foreign_key "commodities", "sellers"
  add_foreign_key "commodities", "shops"
  add_foreign_key "customers", "carts"
  add_foreign_key "customers", "users"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "commodities"
  add_foreign_key "orders", "customers"
  add_foreign_key "sellers", "users"
  add_foreign_key "shops", "sellers"
end
