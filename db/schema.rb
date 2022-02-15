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

ActiveRecord::Schema[7.0].define(version: 2021_11_19_065731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.bigint "property_type_id", null: false
    t.integer "visit_status"
    t.text "visit_comment"
    t.boolean "larvae_found"
    t.boolean "larvicide"
    t.boolean "rodenticide"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "block"
    t.index ["property_type_id"], name: "index_field_forms_on_property_type_id"
    t.index ["user_id"], name: "index_field_forms_on_user_id"
  end

  create_table "institutionals", force: :cascade do |t|
    t.text "description"
    t.string "phone_numbers"
  end

  create_table "larva_species", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "larvas", force: :cascade do |t|
    t.bigint "test_tube_id", null: false
    t.bigint "larva_specy_id", null: false
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larva_specy_id"], name: "index_larvas_on_larva_specy_id"
    t.index ["test_tube_id"], name: "index_larvas_on_test_tube_id"
  end

  create_table "property_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_regions_on_department_id"
  end

  create_table "shed_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_tubes", force: :cascade do |t|
    t.string "code"
    t.bigint "shed_type_id"
    t.integer "collected_amount"
    t.text "comments"
    t.bigint "field_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_form_id"], name: "index_test_tubes_on_field_form_id"
    t.index ["shed_type_id"], name: "index_test_tubes_on_shed_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.boolean "status"
    t.integer "role", default: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.bigint "region_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["region_id"], name: "index_users_on_region_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "field_forms", "property_types"
  add_foreign_key "field_forms", "users"
  add_foreign_key "larvas", "larva_species"
  add_foreign_key "larvas", "test_tubes"
  add_foreign_key "regions", "departments"
  add_foreign_key "test_tubes", "field_forms"
  add_foreign_key "test_tubes", "shed_types"
  add_foreign_key "users", "regions"
end
