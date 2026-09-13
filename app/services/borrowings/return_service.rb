module Borrowings
  class ReturnService
    def call(book_id:)
      book = Book.find_by(id: book_id)
      return { success: false, errors: ['Book not found'] } unless book

      active_borrowing = book.active_borrowing
      return { success: false, errors: ['Book is not currently borrowed'] } unless active_borrowing

      if active_borrowing.update(return_date: Date.current)
        { success: true, borrowing: active_borrowing }
      else
        { success: false, errors: active_borrowing.errors.full_messages }
      end
    end
  end
end
