require 'rspec'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'
require_relative '../../app/model/inscription'

describe Inscription do
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }
  let(:inscription) { described_class.new(student, subject1) }

  describe 'attributes' do
    it 'should respond to student' do
      expect(inscription.student.name).to eq('Juan Perez')
    end

    it 'should respond to subject' do
      expect(inscription.subject.name).to eq('memo2')
    end

    it 'should have a list of grades, initially empty' do
      expect(inscription.grades.empty?).to eq true
    end

    it 'inscription is not passed if grades are empty' do
      expect(inscription.passing?).to eq false
    end

    it 'inscription is passed if a grade above 4 exists' do
      inscription.grades.push(4)
      expect(inscription.passing?).to eq true
    end
  end
end
