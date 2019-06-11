require 'rspec'
require_relative '../../../app/model/graders/midterms_grader'
require_relative '../../../app/exceptions/invalid_grade_error'

describe MidtermsGrader do
  it 'should raise error when the numer of grades is not 2' do
    expect { described_class.new([7, 10, 8]) }.to raise_error(InvalidGradeError)
  end
end
