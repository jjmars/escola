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

ActiveRecord::Schema.define(version: 20160418173808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guardians", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.string   "cpf"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "guardians", ["school_id"], name: "index_guardians_on_school_id", using: :btree

  create_table "guardians_units", id: false, force: :cascade do |t|
    t.integer "guardian_id"
    t.integer "unit_id"
  end

  add_index "guardians_units", ["guardian_id"], name: "index_guardians_units_on_guardian_id", using: :btree
  add_index "guardians_units", ["unit_id"], name: "index_guardians_units_on_unit_id", using: :btree

  create_table "klasses", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "unit_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "klasses", ["school_id"], name: "index_klasses_on_school_id", using: :btree
  add_index "klasses", ["unit_id"], name: "index_klasses_on_unit_id", using: :btree

  create_table "klasses_students", id: false, force: :cascade do |t|
    t.integer "klass_id"
    t.integer "student_id"
  end

  add_index "klasses_students", ["klass_id"], name: "index_klasses_students_on_klass_id", using: :btree
  add_index "klasses_students", ["student_id"], name: "index_klasses_students_on_student_id", using: :btree

  create_table "klasses_teachers", id: false, force: :cascade do |t|
    t.integer "klass_id"
    t.integer "teacher_id"
  end

  add_index "klasses_teachers", ["klass_id"], name: "index_klasses_teachers_on_klass_id", using: :btree
  add_index "klasses_teachers", ["teacher_id"], name: "index_klasses_teachers_on_teacher_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "title"
    t.string   "cnpj"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "unit_id"
    t.integer  "guardian_id"
    t.string   "name"
    t.string   "enrollment"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "students", ["guardian_id"], name: "index_students_on_guardian_id", using: :btree
  add_index "students", ["school_id"], name: "index_students_on_school_id", using: :btree
  add_index "students", ["unit_id"], name: "index_students_on_unit_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.string   "cpf"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teachers", ["school_id"], name: "index_teachers_on_school_id", using: :btree

  create_table "teachers_units", id: false, force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "unit_id"
  end

  add_index "teachers_units", ["teacher_id"], name: "index_teachers_units_on_teacher_id", using: :btree
  add_index "teachers_units", ["unit_id"], name: "index_teachers_units_on_unit_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "units", ["school_id"], name: "index_units_on_school_id", using: :btree

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
    t.integer  "school_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  add_foreign_key "guardians", "schools"
  add_foreign_key "guardians_units", "guardians"
  add_foreign_key "guardians_units", "units"
  add_foreign_key "klasses", "schools"
  add_foreign_key "klasses", "units"
  add_foreign_key "klasses_students", "klasses"
  add_foreign_key "klasses_students", "students"
  add_foreign_key "klasses_teachers", "klasses"
  add_foreign_key "klasses_teachers", "teachers"
  add_foreign_key "students", "guardians"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "units"
  add_foreign_key "teachers", "schools"
  add_foreign_key "teachers_units", "teachers"
  add_foreign_key "teachers_units", "units"
  add_foreign_key "units", "schools"
  add_foreign_key "users", "schools"
end
