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

ActiveRecord::Schema.define(version: 20150531115651) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true

  create_table "allergies", force: true do |t|
    t.string   "allergy_name"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_types", force: true do |t|
    t.string "type_name"
  end

  create_table "customers", force: true do |t|
    t.string   "customer_name"
    t.string   "username"
    t.string   "email"
    t.string   "country"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_type_id"
    t.string   "daycare_user_type"
  end

  add_index "customers", ["customer_type_id"], name: "index_customers_on_customer_type_id"
  add_index "customers", ["username"], name: "index_customers_on_username", unique: true

  create_table "customers_daycare_departments", force: true do |t|
    t.integer "customer_id"
    t.integer "daycare_department_id"
  end

  add_index "customers_daycare_departments", ["customer_id"], name: "index_customers_daycare_departments_on_customer_id"
  add_index "customers_daycare_departments", ["daycare_department_id"], name: "index_customers_daycare_departments_on_daycare_department_id"

  create_table "customers_privileges", force: true do |t|
    t.integer "customer_id"
    t.integer "privilege_id"
  end

  add_index "customers_privileges", ["customer_id"], name: "index_customers_privileges_on_customer_id"
  add_index "customers_privileges", ["privilege_id"], name: "index_customers_privileges_on_privilege_id"

  create_table "daycare_departments", force: true do |t|
    t.string   "department_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privileges", force: true do |t|
    t.string "privilege_name"
  end

end
