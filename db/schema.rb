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

ActiveRecord::Schema.define(version: 20140125172850) do

  create_table "characters", force: true do |t|
    t.string   "name"
    t.string   "actor"
    t.string   "summary"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.integer  "character_id"
    t.integer  "reference_id"
    t.integer  "number"
    t.integer  "season"
    t.string   "title"
    t.string   "summary"
    t.boolean  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references", force: true do |t|
    t.string   "subject"
    t.string   "summary"
    t.string   "image"
    t.string   "link"
    t.string   "line"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

end
