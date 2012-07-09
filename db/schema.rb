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

ActiveRecord::Schema.define(:version => 20120709084425) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "boxes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
    t.string   "description"
    t.integer  "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "source_id"
    t.integer  "target_id"
    t.string   "relation_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "notifications", ["source_id", "target_id", "relation_type"], :name => "index_notifications_on_source_id_and_target_id_and_relation_type"

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.string   "name"
    t.string   "source"
    t.integer  "box_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_remote_url"
  end

  create_table "reports", :force => true do |t|
    t.integer  "source_id"
    t.integer  "target_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reports", ["source_id", "target_id", "title"], :name => "index_reports_on_source_id_and_target_id_and_title"

  create_table "user_box_follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "box_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_user_relationships", :force => true do |t|
    t.integer  "following_id"
    t.integer  "follower_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "user_user_relationships", ["follower_id", "following_id"], :name => "index_user_user_relationships_on_follower_id_and_following_id", :unique => true
  add_index "user_user_relationships", ["follower_id"], :name => "index_user_user_relationships_on_follower_id"
  add_index "user_user_relationships", ["following_id"], :name => "index_user_user_relationships_on_following_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "password_digest"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "about"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "gender"
    t.string   "language"
    t.string   "location"
    t.string   "userName"
    t.string   "website"
    t.string   "perishable_token",    :default => "",    :null => false
    t.boolean  "active",              :default => true
    t.boolean  "admin",               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"

end
