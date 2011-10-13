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

ActiveRecord::Schema.define(:version => 20111013135832) do

  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "country"
    t.string   "email"
    t.string   "fax"
    t.string   "label"
    t.string   "phone"
    t.string   "postal_code"
    t.string   "province"
    t.string   "street"
    t.string   "town"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "organisation_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["organisation_id"], :name => "index_clients_on_organisation_id"

  create_table "invoices", :force => true do |t|
    t.datetime "due_at"
    t.datetime "invoiced_at"
    t.integer  "invoice_number"
    t.integer  "client_id"
    t.integer  "organisation_id"
    t.string   "from"
    t.string   "state"
    t.string   "to"
    t.string   "uuid"
    t.text     "description"
    t.text     "from_address"
    t.text     "notes"
    t.text     "terms"
    t.text     "to_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"
  add_index "invoices", ["organisation_id"], :name => "index_invoices_on_organisation_id"

  create_table "line_items", :force => true do |t|
    t.decimal  "quantity"
    t.decimal  "unit_price"
    t.integer  "invoice_id"
    t.string   "description"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["invoice_id"], :name => "index_line_items_on_invoice_id"

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
