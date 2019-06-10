require 'rspec'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'
require_relative '../../app/model/inscription'
require_relative '../../app/exceptions/invalid_grade_error'
require_relative '../../app/exceptions/no_grades_error'

describe Inscription do
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false, :finals) }
  let(:inscription) { described_class.new(student, subject1) }

  describe 'attributes' do
    it 'should respond to student' do
      expect(inscription.student.name).to eq('Juan Perez')
    end

    it 'should respond to subject' do
      expect(inscription.subject.name).to eq('memo2')
    end
  end

  it 'inscription is not passed if grades are empty' do
    expect(inscription.passing?).to eq false
  end

  it 'inscription is passed if a grade above 4 exists' do
    inscription.add_grades([4])
    expect(inscription.passing?).to eq true
  end

  it 'inscription is not passed if grade is 3' do
    inscription.add_grades([3])
    expect(inscription.passing?).to eq false
  end

  it 'grades can not be above 10' do
    expect { inscription.add_grades([11]) }.to raise_error(InvalidGradeError)
  end

  it 'initially inscription is not graded' do
    expect(inscription.graded?).to eq false
  end

  it 'inscriptions once added a grade are considered graded' do
    inscription.add_grades([3])
    expect(inscription.graded?).to eq true
  end

  it 'grades can not be negative' do
    expect { inscription.add_grades([-1]) }.to raise_error(InvalidGradeError)
  end

  it 'should raise error when grades are not numeric' do
    expect { inscription.add_grades(['a string']) }.to raise_error(InvalidGradeError)
  end

  it 'final grade of a finals subject is the same grade' do
    inscription.add_grades([3])
    expect(inscription.final_grade).to eq 3
  end

  it 'final grade of no grades subject throws an error' do
    expect { inscription.final_grade }.to raise_error(NoGradesError)
  end

  it 'final grade of an assignments subject is the average' do
    subject2 = Subject.new('memo2', '9520', 'SergioV', 30, false, false, :assignments)
    new_inscription = described_class.new(student, subject2)
    new_inscription.add_grades([10, 6])
    expect(new_inscription.final_grade).to eq 8
  end
end
