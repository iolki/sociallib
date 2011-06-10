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

ActiveRecord::Schema.define(:version => 20110323151412) do

  create_table "authors", :force => true do |t|
    t.string   "name",       :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_titles", :id => false, :force => true do |t|
    t.integer "author_id"
    t.integer "title_id"
  end

  add_index "authors_titles", ["author_id"], :name => "index_authors_titles_on_author_id"
  add_index "authors_titles", ["title_id"], :name => "index_authors_titles_on_title_id"

  create_table "books", :force => true do |t|
    t.integer  "title_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     :default => 0
  end

  create_table "loans", :force => true do |t|
    t.integer  "book_id"
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.datetime "returned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "results"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name",       :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", :force => true do |t|
    t.string   "isbn13",      :limit => 13, :default => ""
    t.string   "title",                     :default => ""
    t.string   "subtitle"
    t.text     "description"
    t.string   "image_url"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",               :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "crypted_password",    :default => "", :null => false
    t.string   "password_salt",       :default => "", :null => false
    t.string   "persistence_token",   :default => "", :null => false
    t.string   "single_access_token", :default => "", :null => false
    t.string   "perishable_token",    :default => "", :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "phone"
  end

  create_table "watchings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
