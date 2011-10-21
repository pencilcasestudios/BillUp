class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.datetime :received_at
      t.decimal :amount
      t.integer :receipt_number
      t.references :client
      t.references :organisation
      t.references :reconciliation
      t.string :currency
      t.string :from
      t.string :from_address
      t.string :payment_method
      t.string :to
      t.string :to_address
      t.string :uuid
      t.text :description
      t.text :notes

      t.timestamps
    end
    add_index :receipts, :client_id
    add_index :receipts, :reconciliation_id
    add_index :receipts, :organisation_id
  end
end
