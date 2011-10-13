class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :due_at
      t.datetime :invoiced_at
      t.integer :invoice_number
      t.references :client
      t.references :organisation
      t.string :from
      t.string :state
      t.string :to
      t.string :uuid
      t.text :description
      t.text :from_address
      t.text :notes
      t.text :terms
      t.text :to_address

      t.timestamps
    end
    add_index :invoices, :organisation_id
    add_index :invoices, :client_id
  end
end
