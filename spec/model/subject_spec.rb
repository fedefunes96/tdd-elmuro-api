require 'rspec'
require_relative '../../app/exceptions/student_limit_error'

describe Subject do
  it 'max students has to be at most 300' do
    expect do
      described_class.new('memo2', '9521', 500)
    end.to raise_error(StudentLimitError)
  end
end
