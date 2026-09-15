class Book < ApplicationRecord
  has_many :borrowings, dependent: :destroy
  has_many :readers, through: :borrowings

  has_one :active_borrowing, -> { where(return_date: nil) }, class_name: "Borrowing"

  validates :serial_number, presence: true, uniqueness: true, length: { is: 6 }
  validates :title, presence: true
  validates :author, presence: true
end
