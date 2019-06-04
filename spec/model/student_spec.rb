require 'rspec'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'

describe Student do
  let(:student) { described_class.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }

  describe 'attributes' do
    it 'should respond to name' do
      expect(student.name).to eq('Juan Perez')
    end

    it 'should respond to username' do
      expect(student.username).to eq('juanperez')
    end
  end

  it 'should inscript to a subject' do
    student.inscript(subject1)

    expect(student.inscripted_in(subject1)).to eq(true)
  end
end
