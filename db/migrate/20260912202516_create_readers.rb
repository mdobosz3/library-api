class CreateReaders < ActiveRecord::Migration[8.1]
  def change
    create_table :readers do |t|
      t.string :card_number
      t.string :full_name
      t.string :email

      t.timestamps
    end
    add_index :readers, :card_number, unique: true
    add_index :readers, :email, unique: true
  end
end
