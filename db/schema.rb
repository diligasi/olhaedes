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

ActiveRecord::Schema[7.0].define(version: 2022_02_28_232407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_type_id", null: false
    t.integer "status", default: 0
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "block"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.integer "visit_status"
    t.text "visit_comment"
    t.boolean "larvae_found", default: false
    t.boolean "larvicide", default: false
    t.boolean "rodenticide", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_type_id"], name: "index_field_forms_on_property_type_id"
    t.index ["user_id"], name: "index_field_forms_on_user_id"
  end

  create_table "property_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_regions_on_department_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "cpf", limit: 11, default: "", null: false
    t.boolean "status", default: false, null: false
    t.integer "role", default: 3, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "region_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["region_id"], name: "index_users_on_region_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "field_forms", "property_types"
  add_foreign_key "field_forms", "users"
  add_foreign_key "regions", "departments"
  add_foreign_key "users", "regions"
end