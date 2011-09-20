class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :cell_phone_number
      t.string :language
      t.string :time_zone
      t.string :email

      t.timestamps
    end
  end
end
