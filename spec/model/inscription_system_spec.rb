require 'rspec'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'
require_relative '../../app/model/inscription_system'
require_relative '../../app/exceptions/duplicate_inscription_error'
require_relative '../../app/exceptions/no_available_quota_error'

describe InscriptionSystem do
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }
  let(:subject2) { Subject.new('memo2', '9521', 'NicoPaez', 1, false, false) }
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

  it 'should not let a student inscript twice to the same subject' do
    inscription_system.create_inscription(student, subject1)

    expect do
      inscription_system.create_inscription(student, subject1)
    end.to raise_error(DuplicateInscriptionError)
  end

  it 'should not let a student inscript to a subject without space available' do
    other_student = Student.new('Ignacio Martin', 'ignaciomartin')

    inscription_system.create_inscription(student, subject2)

    expect do
      inscription_system.create_inscription(other_student, subject2)
    end.to raise_error(NoAvailableQuotaError)
  end

  it 'system should load inscriptions when created' do
    inscription = inscription_system.create_inscription(student, subject2)

    new_system = described_class.new([] << inscription)

    expect(new_system.inscripted_to?(student, subject1)).to eq(true)
  end

  it '30 slots subject remaining slots after one inscription should be 29' do
    inscription_system.create_inscription(student, subject1)

    expect(inscription_system.remaining_slots(subject1)).to eq 29
  end

  it 'should say if a student has passed a subject' do
    inscription = inscription_system.create_inscription(student, subject1)
    inscription.add_grades([10])
    expect(inscription_system.passed_subject?(student, subject1)).to eq true
  end

  it 'passed_subject should be false if student has not passed a subject' do
    expect(inscription_system.passed_subject?(student, subject1)).to eq false
  end

  it 'passed_subject should be false if another student has passed the subject' do
    other_student = Student.new('other name', 'other_username')
    inscription = inscription_system.create_inscription(other_student, subject1)
    inscription.add_grades([10])
    expect(inscription_system.passed_subject?(student, subject1)).to eq false
  end
end
