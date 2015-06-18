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

ActiveRecord::Schema.define(version: 20150617120251) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

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
    t.integer  "user_type_id"
  end

  add_index "customers", ["customer_type_id"], name: "index_customers_on_customer_type_id", using: :btree
  add_index "customers", ["user_type_id"], name: "index_customers_on_user_type_id", using: :btree
  add_index "customers", ["username"], name: "index_customers_on_username", unique: true, using: :btree

  create_table "customers_daycare_departments", force: true do |t|
    t.integer "customer_id"
    t.integer "daycare_department_id"
  end

  add_index "customers_daycare_departments", ["customer_id"], name: "index_customers_daycare_departments_on_customer_id", using: :btree
  add_index "customers_daycare_departments", ["daycare_department_id"], name: "index_customers_daycare_departments_on_daycare_department_id", using: :btree

  create_table "customers_privileges", force: true do |t|
    t.integer "customer_id"
    t.integer "privilege_id"
  end

  add_index "customers_privileges", ["customer_id"], name: "index_customers_privileges_on_customer_id", using: :btree
  add_index "customers_privileges", ["privilege_id"], name: "index_customers_privileges_on_privilege_id", using: :btree

  create_table "customers_todos", force: true do |t|
    t.integer "customer_id"
    t.integer "todo_id"
  end

  add_index "customers_todos", ["customer_id"], name: "index_customers_todos_on_customer_id", using: :btree
  add_index "customers_todos", ["todo_id"], name: "index_customers_todos_on_todo_id", using: :btree

  create_table "daycare_departments", force: true do |t|
    t.string   "department_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_type_id"
  end

  add_index "daycare_departments", ["customer_type_id"], name: "index_daycare_departments_on_customer_type_id", using: :btree

  create_table "franchises", force: true do |t|
    t.string   "franchise_name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.text     "address"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "partner_name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.text     "address"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privileges", force: true do |t|
    t.string "privilege_name"
  end

  create_table "subtasks", force: true do |t|
    t.string   "subtask"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subtasks", ["task_id"], name: "index_subtasks_on_task_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "task"
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["todo_id"], name: "index_tasks_on_todo_id", using: :btree

  create_table "todos", force: true do |t|
    t.string   "subject"
    t.datetime "complete_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", force: true do |t|
    t.string  "user_type_name"
    t.integer "customer_type_id"
  end

end
