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

ActiveRecord::Schema.define(version: 2020_12_23_011118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "infection_reports", force: :cascade do |t|
    t.bigint "survivor_id", null: false
    t.bigint "reported_survivor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reported_survivor_id"], name: "index_infection_reports_on_reported_survivor_id"
    t.index ["survivor_id"], name: "index_infection_reports_on_survivor_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "age"
    t.string "name"
    t.string "gender"
    t.jsonb "items"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "infection_reports", "survivors"
  add_foreign_key "infection_reports", "survivors", column: "reported_survivor_id"
end
