require 'rspec'

require_relative '../../../app/model/graders/assignments_grader'

describe AssignmentsGrader do
  it 'one grade above 6 is considered a pass' do
    expect(described_class.new([6]).passing?).to eq true
  end

  it 'a single 4 grade is considered a fail' do
    expect(described_class.new([4]).passing?).to eq false
  end

  it 'an average above or equal to 6 considered a pass' do
    expect(described_class.new([10, 4]).passing?).to eq true
  end

  it 'an average above 6 but with 3 grades under 4 is considered a fail' do
    expect(described_class.new([10, 1, 1, 10, 10]).passing?).to eq false
  end
end
