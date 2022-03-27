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

ActiveRecord::Schema[7.0].define(version: 2022_03_27_001554) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.text "question", null: false
    t.text "answer", null: false
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

  create_table "institutional", force: :cascade do |t|
    t.string "phone_numbers", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "larva_species", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "larvae", force: :cascade do |t|
    t.bigint "test_tube_id", null: false
    t.bigint "larva_species_id", null: false
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larva_species_id"], name: "index_larvae_on_larva_species_id"
    t.index ["test_tube_id"], name: "index_larvae_on_test_tube_id"
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

  create_table "shed_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_tubes", force: :cascade do |t|
    t.bigint "field_form_id", null: false
    t.bigint "shed_type_id", null: false
    t.string "code", null: false
    t.integer "collected_amount"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_form_id"], name: "index_test_tubes_on_field_form_id"
    t.index ["shed_type_id"], name: "index_test_tubes_on_shed_type_id"
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
  add_foreign_key "larvae", "larva_species"
  add_foreign_key "larvae", "test_tubes"
  add_foreign_key "regions", "departments"
  add_foreign_key "test_tubes", "field_forms"
  add_foreign_key "test_tubes", "shed_types"
  add_foreign_key "users", "regions"
end
