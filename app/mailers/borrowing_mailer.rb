class BorrowingMailer < ApplicationMailer
  default from: "library@example.com"

  def reminder_email(borrowing, reminder_type)
    @borrowing = borrowing
    @reader = borrowing.reader
    @book = borrowing.book
    @reminder_type = reminder_type

    subject = if @reminder_type == :upcoming
                "Reminder: Return book '#{@book.title}' in 3 days"
              else
                "Urgent: Today is the due date for book '#{@book.title}'"
              end

    Rails.logger.info "--- SENDING EMAIL TO: #{@reader.email} | SUBJECT: #{subject} ---"
    mail(to: @reader.email, subject: subject)
  end
end
