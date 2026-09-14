class BorrowingReminderWorker
  include Sidekiq::Job

  def perform
    today = Date.current
    three_days_from_now = today + 3.days

    Borrowing.where(return_date: nil, borrow_date: (three_days_from_now - 30.days)).find_each do |borrowing|
      BorrowingMailer.reminder_email(borrowing, :upcoming).deliver_now
    end

    Borrowing.where(return_date: nil, borrow_date: (today - 30.days)).find_each do |borrowing|
      BorrowingMailer.reminder_email(borrowing, :due_today).deliver_now
    end
  end
end
