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

ActiveRecord::Schema.define(version: 20161111163252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "first_user_id"
    t.integer  "second_user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "first_user_messages_count",  default: 0
    t.integer  "second_user_messages_count", default: 0
  end

  create_table "group_lessons", force: :cascade do |t|
    t.integer  "teacher_profile_id"
    t.datetime "day_and_hour"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "subject_id"
  end

  create_table "group_lessons_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_lesson_id"
    t.index ["group_lesson_id"], name: "index_group_lessons_users_on_group_lesson_id", using: :btree
    t.index ["user_id"], name: "index_group_lessons_users_on_user_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "full_address"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "conversation_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "teacher_profile_id"
    t.integer "value"
    t.string  "comment"
    t.string  "reply"
    t.integer "user_id"
    t.index ["teacher_profile_id"], name: "index_ratings_on_teacher_profile_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects_teacher_profiles", id: false, force: :cascade do |t|
    t.integer "subject_id"
    t.integer "teacher_profile_id"
    t.index ["subject_id"], name: "index_subjects_teacher_profiles_on_subject_id", using: :btree
    t.index ["teacher_profile_id"], name: "index_subjects_teacher_profiles_on_teacher_profile_id", using: :btree
  end

  create_table "teacher_experiences", force: :cascade do |t|
    t.integer "teacher_profile_id"
    t.string  "name_of_the_place"
    t.date    "period_start"
    t.date    "period_end"
    t.string  "description"
    t.integer "experience_type"
    t.index ["teacher_profile_id"], name: "index_teacher_experiences_on_teacher_profile_id", using: :btree
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.string  "description"
    t.integer "user_id"
    t.decimal "hour_rate"
    t.integer "type_of_service_cd"
    t.integer "level_cd"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "date_of_birth"
    t.string   "gender"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "identities", "users"
end
