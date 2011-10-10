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

ActiveRecord::Schema.define(:version => 20111008040546) do

  create_table "clients", :force => true do |t|
    t.integer  "organisation_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["organisation_id"], :name => "index_clients_on_organisation_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["organisation_id"], :name => "index_memberships_on_organisation_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "organisations", :force => true do |t|
    t.integer  "invoices_left", :default => 0
    t.integer  "receipts_left", :default => 0
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.decimal  "units",             :precision => 12, :scale => 2, :default => 0.0
    t.string   "cell_phone_number"
    t.string   "email"
    t.string   "language"
    t.string   "name"
    t.string   "password_digest"
    t.string   "time_zone"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
