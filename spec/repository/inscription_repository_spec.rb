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
    subject1 = Subject.new('Orga de compus', '66.20', 'NicoPaez', 15, true, false)
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
    inscription.grades.push(10)
    repo.save(inscription)

    same_inscription = repo.all_inscriptions.first
    expect(same_inscription.grades.first).to eq 10
  end
end
