require 'rspec'

require_relative '../../../app/model/graders/finals_grader'
require_relative '../../../app/exceptions/invalid_grade_error'

describe FinalsGrader do
  let(:grader) { described_class.new }

  it 'accepts a single grade as valid' do
    grader.validate!([10])
  end

  it 'rejects more than one grade as invalid' do
    expect { grader.validate!([10, 10]) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a non numeric grade as invalid' do
    expect { grader.validate!(['aprobado']) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a negative grade as invalid' do
    expect { grader.validate!([-1]) }.to raise_error(InvalidGradeError)
  end

  it 'rejects a grade above 10 as invalid' do
    expect { grader.validate!([11]) }.to raise_error(InvalidGradeError)
  end

  it 'final grade for [6] grades is 6' do
    expect(grader.final_grade([6])).to eq 6
  end

  it 'invalid grades for final_grade throws error' do
    expect { grader.final_grade([-1]) }.to raise_error(InvalidGradeError)
  end
end
