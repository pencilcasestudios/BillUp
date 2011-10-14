class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.decimal :quantity, :precision => 12, :scale => 2, :default => 0
      t.decimal :unit_price, :precision => 12, :scale => 2, :default => 0
      t.references :invoice
      t.string :currency
      t.string :description

      t.timestamps
    end
    add_index :line_items, :invoice_id
  end
end
