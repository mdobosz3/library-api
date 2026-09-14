require 'rails_helper'

RSpec.describe BorrowingMailer, type: :mailer do
  let(:reader) { create(:reader) }
  let(:book) { create(:book) }
  let(:borrowing) { create(:borrowing, reader: reader, book: book, borrow_date: Date.current) }

  describe 'reminder_email' do
    context 'when reminder type is upcoming (3 days before)' do
      let(:mail) { described_class.reminder_email(borrowing, :upcoming) }

      it 'renders the headers and body correctly' do
        expect(mail.subject).to eq("Reminder: Return book '#{book.title}' in 3 days")
        expect(mail.to).to eq([reader.email])
        expect(mail.from).to eq(['library@example.com'])
        expect(mail.body.encoded).to include(reader.full_name)
        expect(mail.body.encoded).to include(book.title)
      end
    end

    context 'when reminder type is due_today' do
      let(:mail) { described_class.reminder_email(borrowing, :due_today) }

      it 'renders the headers and body correctly' do
        expect(mail.subject).to eq("Urgent: Today is the due date for book '#{book.title}'")
        expect(mail.to).to eq([reader.email])
        expect(mail.body.encoded).to include(reader.full_name)
        expect(mail.body.encoded).to include(book.title)
      end
    end
  end
end
