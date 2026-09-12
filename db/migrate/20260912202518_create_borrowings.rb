class CreateBorrowings < ActiveRecord::Migration[8.1]
  def change
    create_table :borrowings do |t|
      t.references :book, null: false, foreign_key: true
      t.references :reader, null: false, foreign_key: true
      t.date :borrow_date, null: false
      t.date :return_date

      t.timestamps
    end
  end
end
