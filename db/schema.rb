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

ActiveRecord::Schema.define(:version => 20130426232938) do

  create_table "learners", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "interests"
    t.string   "major"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sharers", :force => true do |t|
    t.integer  "user_id"
    t.string   "credentials"
    t.string   "major"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "workshop_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "upvotes", :force => true do |t|
    t.integer  "workshop_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "active"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "interests"
  end

  create_table "workshops", :force => true do |t|
    t.integer  "sharer_id"
    t.integer  "learner_id"
    t.boolean  "active"
    t.datetime "start_time"
    t.datetime "end_time"
    t.date     "date"
    t.integer  "size"
    t.string   "category"
    t.string   "location"
    t.string   "subdescription"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
