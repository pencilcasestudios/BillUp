class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.decimal :units, :precision => 12, :scale => 2, :default => 0
      t.string :cell_phone_number
      t.string :email
      t.string :language
      t.string :name
      t.string :password_digest
      t.string :time_zone
      t.string :username

      t.timestamps
    end
  end
end
