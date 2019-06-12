require 'rspec'
require_relative '../../../app/model/graders/midterms_grader'
require_relative '../../../app/exceptions/invalid_grade_error'

describe MidtermsGrader do
  it 'should raise error when the number of grades is above 2' do
    expect { described_class.new([7, 10, 8]) }.to raise_error(InvalidGradeError)
  end

  it 'should raise error when number of grades is less than 2' do
    expect { described_class.new([7]) }.to raise_error(InvalidGradeError)
  end

  it 'should return mean of grades as final grade' do
    expect(described_class.new([10, 8]).final_grade).to eq 9
  end

  it 'should not be passsing if final grade is under 6' do
    expect(described_class.new([4, 4]).passing?).to eq false
  end

  it 'should be passing if final grade is above 6' do
    expect(described_class.new([8, 7]).passing?).to eq true
  end

  it 'shold raise error if grade is empty' do
    expect { described_class.new([]) }.to raise_error(InvalidGradeError)
  end
end
