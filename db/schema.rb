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

ActiveRecord::Schema.define(:version => 20140316233425) do

  create_table "events", :force => true do |t|
    t.text     "description"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "charts"
    t.text     "quotes"
  end

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], :name => "index_events_users_on_event_id_and_user_id"
  add_index "events_users", ["user_id"], :name => "index_events_users_on_user_id"

  create_table "experiences", :force => true do |t|
    t.integer  "resume_id"
    t.date     "start_date",                       :null => false
    t.date     "end_date"
    t.string   "organization",                     :null => false
    t.string   "location",                         :null => false
    t.string   "title",                            :null => false
    t.text     "description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "kind",         :default => "work", :null => false
  end

  create_table "external_posts", :force => true do |t|
    t.string   "provider",                      :null => false
    t.string   "guid",                          :null => false
    t.string   "url",                           :null => false
    t.text     "title",                         :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.datetime "pubdate"
    t.boolean  "deleted",    :default => false, :null => false
  end

  add_index "external_posts", ["guid"], :name => "index_external_posts_on_guid", :unique => true
  add_index "external_posts", ["provider"], :name => "index_external_posts_on_provider"
  add_index "external_posts", ["pubdate"], :name => "index_external_posts_on_pubdate"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "published",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "resumes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",         :null => false
    t.date     "birthdate"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug"
    t.string   "street"
    t.integer  "postcode"
    t.string   "city"
    t.string   "image"
    t.string   "linkedin_url"
  end

  add_index "resumes", ["slug"], :name => "index_resumes_on_slug", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "tag_id", "context"], :name => "index_taggings_on_keys"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                                    :null => false
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "role",                         :default => "organization", :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "contact_name"
    t.string   "contact_phone"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
