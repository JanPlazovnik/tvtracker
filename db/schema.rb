# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_04_105112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "episode_id"
    t.index ["episode_id"], name: "index_comments_on_episode_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "title", default: ""
    t.text "summary", default: ""
    t.bigint "season_id"
    t.integer "tvdb_episode_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ep_number"
    t.datetime "date_aired"
    t.index ["season_id"], name: "index_episodes_on_season_id"
    t.index ["tvdb_episode_id"], name: "index_episodes_on_tvdb_episode_id", unique: true
  end

  create_table "episodes_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "episode_id", null: false
    t.index ["episode_id", "user_id"], name: "index_episodes_users_on_episode_id_and_user_id"
    t.index ["user_id", "episode_id"], name: "index_episodes_users_on_user_id_and_episode_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "number", default: 0, null: false
    t.bigint "series_id"
    t.integer "tvdb_season_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["series_id"], name: "index_seasons_on_series_id"
    t.index ["tvdb_season_id"], name: "index_seasons_on_tvdb_season_id", unique: true
  end

  create_table "series", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "summary", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tvdb_id"
    t.string "image"
    t.string "status"
    t.datetime "first_aired"
    t.string "airs_day_of_week"
    t.string "airs_time"
    t.integer "runtime"
  end

  create_table "series_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "series_id", null: false
    t.index ["series_id"], name: "index_series_users_on_series_id"
    t.index ["user_id"], name: "index_series_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "episodes"
  add_foreign_key "comments", "users"
end
