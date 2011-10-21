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

ActiveRecord::Schema.define(:version => 20111021183807) do

  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "cell_phone_number"
    t.string   "country"
    t.string   "email"
    t.string   "fax_number"
    t.string   "label"
    t.string   "land_line_number"
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
    t.string   "pdf_password"
    t.string   "pdf_password_hint"
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
    t.decimal  "quantity",    :precision => 12, :scale => 2, :default => 1.0
    t.decimal  "unit_price",  :precision => 12, :scale => 2, :default => 0.0
    t.integer  "invoice_id"
    t.string   "currency"
    t.string   "description"
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
    t.integer  "preferred_due_in_period", :default => 28
    t.integer  "leaves_left",             :default => 0
    t.string   "name"
    t.string   "subdomain"
    t.text     "preferred_notes"
    t.text     "preferred_terms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", :force => true do |t|
    t.datetime "received_at"
    t.decimal  "amount"
    t.integer  "receipt_number"
    t.integer  "client_id"
    t.integer  "organisation_id"
    t.integer  "reconciliation_id"
    t.string   "currency"
    t.string   "from"
    t.string   "from_address"
    t.string   "payment_method"
    t.string   "to"
    t.string   "to_address"
    t.string   "uuid"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "receipts", ["client_id"], :name => "index_receipts_on_client_id"
  add_index "receipts", ["organisation_id"], :name => "index_receipts_on_organisation_id"
  add_index "receipts", ["reconciliation_id"], :name => "index_receipts_on_reconciliation_id"

  create_table "sub_factors", :force => true do |t|
    t.decimal  "amount",       :precision => 12, :scale => 2, :default => 1.0
    t.integer  "line_item_id"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_factors", ["line_item_id"], :name => "index_sub_factors_on_line_item_id"

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

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
