class CreateSequencesForSerialNumbers < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE SEQUENCE book_serial_seq START 1"
    execute "CREATE SEQUENCE reader_card_seq START 1"
  end

  def down
    execute "DROP SEQUENCE book_serial_seq"
    execute "DROP SEQUENCE reader_card_seq"
  end
end
