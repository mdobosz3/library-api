module Borrowings
  class CheckoutService
    def call(book_id:, reader_id:)
      ActiveRecord::Base.transaction do
        book = Book.find(book_id)
        reader = Reader.find(reader_id)

        borrowing = Borrowing.new(
          book: book,
          reader: reader,
          borrow_date: Date.current
        )

        if borrowing.save
          { success: true, borrowing: borrowing }
        else
          { success: false, errors: borrowing.errors.full_messages }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      { success: false, errors: [ e.message ] }
    end
  end
end
