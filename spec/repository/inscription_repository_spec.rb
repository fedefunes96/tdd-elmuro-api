require 'date'
require 'rspec'
require 'spec_helper'
require_relative '../../app/model/subject'
require_relative '../../app/model/student'
require_relative '../../app/model/inscription'
require_relative '../../repositories/inscription_repository'

describe 'InscriptionRepository' do
  let(:repo) { InscriptionRepository.new }
  let(:student1) do
    student = Student.new('Juan Perez', 'juanperez')
    StudentRepository.new.save(student)
    student
  end
  let(:subject1) do
    subject1 = Subject.new('Orga de compus', '6620', 'NicoPaez', 15, true, false)
    SubjectRepository.new.save(subject1)
    subject1
  end
  let(:inscription) do
    inscription = Inscription.new(student1, subject1)
    inscription
  end

  it 'saves correctly' do
    repo.save(inscription)

    inscriptions = repo.all_inscriptions

    expect(inscriptions.include?(inscription)).to eq(true)
  end

  it 'deletes correctly' do
    repo.save(inscription)
    repo.delete(inscription)

    inscriptions = repo.all_inscriptions

    expect(inscriptions.include?(inscription)).to eq(false)
  end

  it 'persists grades' do
    inscription.add_grades([10])
    repo.save(inscription)

    same_inscription = repo.all_inscriptions.first
    expect(same_inscription.passing?).to eq true
  end

  it 'can find by student username and subject code' do
    repo.save(inscription)

    new_inscription = repo.find_by_student_and_code(student1.username, subject1.code)
    expect(inscription).to eq new_inscription
  end
end
