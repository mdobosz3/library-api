module Api
  module V1
    class BorrowingsController < ApplicationController
      def checkout
        Rails.logger.info "--- NAGŁÓWEK Content-Type: #{request.content_type} ---"
  Rails.logger.info "--- SUROWE BODY Z POSTMANA: #{request.raw_post} ---"
  
        json_params = parse_json_body
        book_id = json_params['book_id'] || params[:book_id]
        reader_id = json_params['reader_id'] || params[:reader_id]
        card_number = json_params['card_number'] || params[:card_number]

        book = Book.find_by(id: book_id)
        reader = Reader.find_by(card_number: card_number) || Reader.find_by(id: reader_id)

        unless book
          return render json: { error: 'Book not found' }, status: :not_found
        end

        unless reader
          return render json: { error: 'Reader not found' }, status: :not_found
        end

        if book.borrowings.where(return_date: nil).exists?
          return render json: { error: 'Book is already borrowed' }, status: :unprocessable_content
        end

        borrowing = Borrowing.new(book: book, reader: reader, borrow_date: Date.current)

        if borrowing.save
          render json: borrowing, status: :created
        else
          render json: { errors: borrowing.errors.full_messages }, status: :unprocessable_content
        end
      end

      def return
        json_params = parse_json_body
        book_id = json_params['book_id'] || params[:book_id]

        book = Book.find_by(id: book_id)

        unless book
          return render json: { error: 'Book not found' }, status: :not_found
        end

        borrowing = book.borrowings.find_by(return_date: nil)

        unless borrowing
          return render json: { error: 'Book is not currently borrowed' }, status: :unprocessable_content
        end

        if borrowing.update(return_date: Date.current)
          render json: borrowing, status: :ok
        else
          render json: { errors: borrowing.errors.full_messages }, status: :unprocessable_content
        end
      end

      private

      def parse_json_body
        request.body.rewind
        raw = request.body.read
        raw.present? ? JSON.parse(raw) : {}
      rescue StandardError
        {}
      end
    end
  end
end
