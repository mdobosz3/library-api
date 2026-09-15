class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :reader

  validates :borrow_date, presence: true
  validate :book_must_be_available, on: :create

  private

  def book_must_be_available
    if Borrowing.where(book_id: book_id, return_date: nil).exists?
      errors.add(:book, "is already borrowed")
    end
  end
end
