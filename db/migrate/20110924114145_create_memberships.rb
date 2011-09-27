class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :organisation

      t.timestamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :organisation_id
  end
end
