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
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Books::DestroyService.new.call(params[:id])

        if result[:success]
          head :no_content
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
