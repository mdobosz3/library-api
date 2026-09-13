require 'rails_helper'

RSpec.describe Reader, type: :model do
  it 'is valid with correct email and 6-digit card number' do
    reader = build(:reader)
    expect(reader).to be_valid
  end

  it 'is invalid with an incorrect email format' do
    reader = build(:reader, email: 'invalid-email')
    expect(reader).not_to be_valid
  end
end
