class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :organisation
      t.string :name
      t.string :invoice_password

      t.timestamps
    end
    add_index :clients, :organisation_id
  end
end
