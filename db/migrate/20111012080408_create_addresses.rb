class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :cell_phone_number
      t.string :country
      t.string :email
      t.string :fax_number
      t.string :label
      t.string :land_line_number
      t.string :postal_code
      t.string :province
      t.string :street
      t.string :town
      t.string :website

      t.timestamps
    end
  end
end
