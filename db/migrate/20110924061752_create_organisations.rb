class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.integer :preferred_due_in_period, default: 28 # days
      t.integer :leaves_left, default: 0
      t.string :name
      t.string :subdomain
      t.text :preferred_notes
      t.text :preferred_terms

      t.timestamps
    end
  end
end
