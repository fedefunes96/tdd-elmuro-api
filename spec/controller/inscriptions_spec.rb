require 'rspec'
require 'rack/test'
require_relative '../../app/app'

describe 'Inscripcion alumnos' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:subject1) { Subject.new('Tecnicas 2', '7592', 'NicoPaez', 10, true, false, :finals) }

  before(:each) do
    SubjectRepository.new.save(subject1)
  end

  it 'accepts a post to /alumnos' do
    post_with_body('/alumnos', {})
    expect(last_response.status).not_to eq 404
  end

  it 'creates a new inscription' do
    post_with_body('/alumnos', nombre_completo: 'Juan Perez',
                               username_alumno: 'juanperez', codigo_materia: '7592')
    expect(last_response.status).to eq 201
  end

  it 'new inscription created is persisted on db' do
    post_with_body('/alumnos', nombre_completo: 'Juan Perez',
                               username_alumno: 'juanperez', codigo_materia: '7592')

    inscriptions = InscriptionRepository.new.all_inscriptions

    expect(inscriptions.include?(Inscription.new(student, subject1))).to eq true
  end

  it 'responds with error if subject does not exist' do
    post_with_body('/alumnos', nombre_completo: 'Juan Perez',
                               username_alumno: 'juanperez', codigo_materia: '1000')

    expect(last_response.status).to eq 400
  end

  it 'responds with error if twice inscription' do
    post_with_body('/alumnos', nombre_completo: 'Juan Perez',
                               username_alumno: 'juanperez', codigo_materia: '7592')
    post_with_body('/alumnos', nombre_completo: 'Juan Perez',
                               username_alumno: 'juanperez', codigo_materia: '7592')
    expect(last_response.status).to eq 400
  end
end
