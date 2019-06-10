require 'rspec'

require_relative '../../../app/model/graders/finals_grader'

describe FinalsGrader do
  it 'accepts a single grade as valid' do
    described_class.new.validate!([10])
  end

  it 'rejects more than one grade as invalid' do
    described_class.new.validate!([10, 10])
  end
end
