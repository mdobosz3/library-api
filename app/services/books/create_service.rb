# module Books
#   class CreateService
#     def call(params)
#       serial_number = SecureRandom.alphanumeric(6).upcase
#       book = Book.new(params.merge(serial_number: serial_number))

#       if book.save
#         { success: true, book: book }
#       else
#         { success: false, errors: book.errors.full_messages }
#       end
#     end
#   end
# end

module Books
  class CreateService
    def call(params)
      serial_number = generate_serial_number
      book = Book.new(params.merge(serial_number: serial_number))

      if book.save
        { success: true, book: book }
      else
        { success: false, errors: book.errors.full_messages }
      end
    end

    private

    def generate_serial_number
      # Pobieramy kolejny numer z sekwencji bazodanowej i uzupełniamy do 6 znaków
      next_value = ActiveRecord::Base.connection.select_value(
        "SELECT nextval('book_serial_seq')"
      )
      next_value.to_s.rjust(6, '0')
    end
  end
end
