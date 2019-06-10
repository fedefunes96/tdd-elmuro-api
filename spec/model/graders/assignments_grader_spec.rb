require 'rspec'

require_relative '../../../app/model/graders/assignments_grader'

describe AssignmentsGrader do
  it 'one grade above 6 is considered a pass' do
    expect(described_class.new([6]).passing?).to eq true
  end

  it 'a single 4 grade is considered a fail' do
    expect(described_class.new([4]).passing?).to eq false
  end
end
