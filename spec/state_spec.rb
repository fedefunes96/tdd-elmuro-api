require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Estado alumno' do
  include Rack::Test::Methods

  let(:student1) do
    student = Student.new('Juan Perez', 'juanperez')
    StudentRepository.new.save(student)
    student
  end
  let(:subject1) do
    subject1 = Subject.new('Orga de compus', '1001', 'NicoPaez', 15, true, false)
    SubjectRepository.new.save(subject1)
    subject1
  end
  let(:inscription) do
    inscription = Inscription.new(student1, subject1)
    inscription
  end

  def app
    Sinatra::Application
  end

  it 'accepts a get to /estado' do
    get_with_body('/estado', {})
    expect(last_response.status).not_to eq 404
  end

  it 'responds with user not inscripted if user is not inscripted' do
    get_with_body('/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
    expect(last_response.status).to eq 200
  end

  it 'responds error if subject does not exists' do
    get_with_body('/estado', usernameAlumno: student1.username, codigoMateria: '3000')
    expect(last_response.status).to eq 400
  end
end
