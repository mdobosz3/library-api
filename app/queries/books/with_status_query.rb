module Books
  class WithStatusQuery
    def initialize(relation = Book.all)
      @relation = relation
    end

    def call
      @relation.includes(:active_borrowing).order(created_at: :desc)
    end
  end
end
