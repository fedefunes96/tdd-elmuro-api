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
  end
end
