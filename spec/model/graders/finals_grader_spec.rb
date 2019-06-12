require 'rspec'

require_relative '../../../app/model/graders/finals_grader'
require_relative '../../../app/exceptions/invalid_grade_error'

describe FinalsGrader do
  it 'accepts a single grade as valid' do
    described_class.new([10])
  end

  it 'rejects more than one grade as invalid' do
    expect { described_class.new([10, 10]) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a non numeric grade as invalid' do
    expect { described_class.new(['aprobado']) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a negative grade as invalid' do
    expect { described_class.new([-1]) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a grade above 10 as invalid' do
    expect { described_class.new([11]) }.to raise_error(InvalidGradeError)
  end

  it 'final grade for [6] grades is 6' do
    expect(described_class.new([6]).final_grade).to eq 6
  end

  it 'passing is true if grade is above or equal to 4' do
    expect(described_class.new([6]).passing?).to eq true
  end

  it 'passing is false if grade is below 4' do
    expect(described_class.new([2]).passing?).to eq false
  end

  it 'shold raise error if grade is empty' do
    expect { described_class.new([]) }.to raise_error(InvalidGradeError)
  end
end
