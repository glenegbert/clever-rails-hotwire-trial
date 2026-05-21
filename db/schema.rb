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

ActiveRecord::Schema[8.1].define(version: 2026_05_21_145152) do
  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "photo_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["photo_id"], name: "index_likes_on_photo_id"
    t.index ["user_id", "photo_id"], name: "index_likes_on_user_id_and_photo_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.string "photographer", null: false
    t.string "source_url", null: false
    t.string "src_medium", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "likes", "photos"
  add_foreign_key "likes", "users"
end
