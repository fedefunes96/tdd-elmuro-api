require 'rspec'

require_relative '../../../app/model/graders/finals_grader'
require_relative '../../../app/exceptions/invalid_grade_error'

describe FinalsGrader do
  it 'accepts a single grade as valid' do
    described_class.new.validate!([10])
  end

  it 'rejects more than one grade as invalid' do
    expect { described_class.new.validate!([10, 10]) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a non numeric grade as invalid' do
    expect { described_class.new.validate!(['aprobado']) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a negative grade as invalid' do
    expect { described_class.new.validate!([-1]) }.to raise_error(InvalidGradeError)
  end
end
