module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Books::WithStatusQuery.new.call
        
        render json: books.as_json(
          only: [:id, :serial_number, :title, :author],
          include: { 
            active_borrowing: { 
              only: [:borrow_date, :reader_id] 
            } 
          }
        ), status: :ok
      end

      def show
        book = Book.includes(borrowings: :reader).find(params[:id])

        render json: book.as_json(
          only: [:id, :serial_number, :title, :author, :created_at, :updated_at],
          include: {
            borrowings: {
              only: [:id, :borrow_date, :return_date],
              include: {
                reader: {
                  only: [:id, :card_number, :full_name, :email]
                }
              }
            }
          }
        ), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Book not found' }, status: :not_found
      end

      def create
        
        json_params = begin
          request.body.rewind
          JSON.parse(request.body.read)
        rescue StandardError
          {}
        end

        book_data = json_params['book'] || params.permit(book: [:title, :author])[:book] || params

        result = Books::CreateService.new.call(book_data)

        if result[:success]
          render json: result[:book], status: :created
        else
          render json: { errors: result[:errors] }, status: :unprocessable_content
        end
      end

      def destroy
        result = Books::DestroyService.new.call(params[:id])

        if result[:success]
          head :no_content
        else
          render json: { errors: result[:errors] }, status: :unprocessable_content
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
