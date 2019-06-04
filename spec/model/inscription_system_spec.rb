require 'rspec'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'
require_relative '../../app/model/inscription_system'
require_relative '../../app/exceptions/invalid_inscription'

describe InscriptionSystem do
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }
  let(:inscription_system) { described_class.new }

  it 'should create inscriptions' do
    inscription = inscription_system.create_inscription(student, subject1)

    expect(inscription.subject.name).to eq('memo2')
    expect(inscription.student.name).to eq('Juan Perez')
  end

  it 'should know if a student is inscripted to a subject' do
    inscription_system.create_inscription(student, subject1)

    expect(inscription_system.inscripted_to?(student, subject1)).to eq(true)
  end
end
