class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :from
      t.string :from_address
      t.string :to
      t.string :to_address
      t.decimal :amount
      t.string :currency
      t.datetime :received_at
      t.text :notes
      t.string :payment_method
      t.references :client
      t.references :reconciliation
      t.references :organisation

      t.timestamps
    end
    add_index :receipts, :client_id
    add_index :receipts, :reconciliation_id
    add_index :receipts, :organisation_id
  end
end
