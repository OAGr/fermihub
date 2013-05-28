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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130528081142) do

  create_table "distributions", :force => true do |t|
    t.float    "mean"
    t.float    "spread"
    t.float    "wideness"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "operation_id"
    t.string   "type"
    t.string   "name"
  end

  create_table "distributions_models", :id => false, :force => true do |t|
    t.integer "distribution_id"
    t.integer "model_id"
  end

  create_table "distributions_operations", :id => false, :force => true do |t|
    t.integer "distribution_id"
    t.integer "operation_id"
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "operations", :force => true do |t|
    t.string   "operator"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sqlite_sp_functions", :id => false, :force => true do |t|
    t.text "name"
    t.text "text"
  end

# Could not dump table "sqlite_stat1" because of following StandardError
#   Unknown type '' for column 'tbl'

# Could not dump table "sqlite_stat3" because of following StandardError
#   Unknown type '' for column 'tbl'

  create_table "sqlite_vs_links_names", :id => false, :force => true do |t|
    t.text "name"
    t.text "alias"
  end

  create_table "sqlite_vs_properties", :id => false, :force => true do |t|
    t.text "parentType"
    t.text "parentName"
    t.text "propertyName"
    t.text "propertyValue"
  end

  create_table "sqlite_vsp_diagrams", :id => false, :force => true do |t|
    t.text "name"
    t.text "diadata"
    t.text "comment"
    t.text "preview"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
