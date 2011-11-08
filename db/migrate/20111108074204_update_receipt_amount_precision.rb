class UpdateReceiptAmountPrecision < ActiveRecord::Migration
  def up
    change_column :receipts,  :amount,    :decimal, :precision => 12, :scale => 2, :default => 0
  end

  def down
    change_column :receipts,  :amount,    :decimal
  end
end
