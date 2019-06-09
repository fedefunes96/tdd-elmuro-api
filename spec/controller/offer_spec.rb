require 'rspec'
require 'rack/test'
require_relative '../../app/app'
require_relative '../spec_helper'

describe 'Alta materias' do
  include Rack::Test::Methods
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('Tecnicas 2', '7592', 'NicoPaez', 10, true, false) }
  let(:inscription) { Inscription.new(student, subject1) }

  before(:each) do
    StudentRepository.new.save(student)
    SubjectRepository.new.save(subject1)
    InscriptionRepository.new.save(inscription)
  end

  def app
    Sinatra::Application
  end

  it 'should respond with status code different than 404' do
    get_with_token('/materias', usernameAlumno: 'juanperez')
    expect(last_response.status).not_to eq 404
  end

  it 'should respond with a subject list' do
    get_with_token('/materias', usernameAlumno: 'juanperez')
    expect(JSON.parse(last_response.body)['oferta'].class).to eq Array
  end

  describe 'subject responses' do
    it 'subject should have a code' do
      subjects = response_offer
      expect(subjects.first['codigo']).to eq subject1.code
    end

    it 'subject should have a name' do
      subjects = response_offer
      expect(subjects.first['nombre']).to eq subject1.name
    end

    it 'subject should have a teacher' do
      subjects = response_offer
      expect(subjects.first['docente']).to eq subject1.teacher
    end

    it 'subject should have a quota number' do
      subjects = response_offer
      expect(subjects.first['cupo']).to eq subject1.max_students - 1
    end
  end

  it 'subjects already passed should not show up in offer' do
    inscription.add_grades([10])
    InscriptionRepository.new.save(inscription)
    subjects = response_offer
    expect(subjects.empty?).to eq true
  end

  it 'two subjects should show up in the offer if both exist' do
    SubjectRepository.new.save(Subject.new('Tecnicas 1', '7510', 'Emilio', 10, true, false))
    subjects = response_offer
    expect(subjects.size).to eq 2
  end

  it 'if student is not in database it returns all subjects' do
    get_with_token('/materias', usernameAlumno: 'alumno_no_registrado')
    subjects = JSON.parse(last_response.body)['oferta']
    expect(subjects.size).to eq 1
  end

  def response_offer
    get_with_token('/materias', usernameAlumno: 'juanperez')
    JSON.parse(last_response.body)['oferta']
  end
end
