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
    expect(described_class.new([10, 1, 1, 3, 10, 10]).passing?).to eq false
  end

  it 'an average above 6 but with 2 grades under 4 is considered a pass' do
    expect(described_class.new([10, 1, 1, 10, 10]).passing?).to eq true
  end

  it 'final grade is the mean grade' do
    expect(described_class.new([10]).final_grade).to eq 10
  end

  it 'final grade of several grades is the mean grade' do
    expect(described_class.new([10, 9, 8]).final_grade).to eq 9
  end

  it 'average under 6 is considered a fail' do
    expect(described_class.new([10, 1]).passing?).to eq false
  end

  it 'if more than 2 failing grades, final grade is 1' do
    expect(described_class.new([10, 1, 1, 3, 10, 10]).final_grade).to eq 1
  end
end
