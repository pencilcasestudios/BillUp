class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.integer :invoices_left, :default => 0
      t.integer :receipts_left, :default => 0
      t.string :name
      t.string :subdomain

      t.timestamps
    end
  end
end
