class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :organisation
      t.string :name
      t.string :pdf_password
      t.string :pdf_password_hint

      t.timestamps
    end
    add_index :clients, :organisation_id
  end
end
