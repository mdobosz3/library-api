module Books
  class DestroyService
    def call(book_id)
      book = Book.find_by(id: book_id)
      return { success: false, errors: ['Book not found'] } unless book

      if book.active_borrowing.present?
        return { success: false, errors: ['Cannot delete a book that is currently borrowed'] }
      end

      book.destroy
      { success: true }
    end
  end
end
