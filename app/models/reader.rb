class Reader < ApplicationRecord
  has_many :borrowings, dependent: :destroy
  has_many :books, through: :borrowings

  validates :card_number, presence: true, uniqueness: true, length: { is: 6 }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
