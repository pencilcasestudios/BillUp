class CreateSubFactors < ActiveRecord::Migration
  def change
    create_table :sub_factors do |t|
      t.decimal :amount, :precision => 12, :scale => 2, :default => 1
      t.references :line_item
      t.string :units

      t.timestamps
    end
    add_index :sub_factors, :line_item_id
  end
end
