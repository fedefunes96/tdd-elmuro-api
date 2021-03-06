require 'rspec'
require 'rack/test'
require_relative '../../app/app'

describe 'Estado alumno' do
  include Rack::Test::Methods

  let(:student1) do
    student = Student.new('Juan Perez', 'juanperez')
    StudentRepository.new.save(student)
    student
  end
  let(:subject1) do
    subject1 = Subject.new('Orga de compus', '1001', 'NicoPaez', 15, true, false, :finals)
    SubjectRepository.new.save(subject1)
    subject1
  end
  let(:subject2) do
    subject2 = Subject.new('Memo2', '2020', 'NicoPaez', 15, true, false, :midterms)
    SubjectRepository.new.save(subject2)
    subject2
  end
  let(:inscription) do
    inscription = Inscription.new(student1, subject1)
    inscription
  end
  let(:inscription2) do
    inscription2 = Inscription.new(student1, subject2)
    inscription2
  end

  def app
    Sinatra::Application
  end

  it 'accepts a get to /estado' do
    get_with_token('/materias/estado', {})
    expect(last_response.status).not_to eq 404
  end

  it 'responds with user not inscripted if user is not inscripted' do
    get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)['estado']).to eq('NO_INSCRIPTO')
  end

  it 'responds with no grade if user not inscripted' do
    get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)['nota_final']).to eq(nil)
  end

  it 'responds ok if user is inscripted to the subject' do
    InscriptionRepository.new.save(inscription)
    get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)['estado']).to eq('EN_CURSO')
  end

  it 'responds with no grade if user inscripted but not yet graded' do
    InscriptionRepository.new.save(inscription)
    get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)['nota_final']).to eq(nil)
  end

  it 'responds with error if it does not have all the params' do
    InscriptionRepository.new.save(inscription)
    get_with_token('/materias/estado', usernameAlumno: student1.username)
    expect(last_response.status).to eq 400
  end

  context 'when Student graded in a subject' do
    before(:each) do
      InscriptionRepository.new.save(inscription)
      InscriptionRepository.new.save(inscription2)
    end

    it 'responds ok if user is inscripted to the subject and approved' do
      post_with_body('/calificar', codigo_materia: subject1.code,
                                   notas: '10',
                                   username_alumno: student1.username)

      get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
      expect(JSON.parse(last_response.body)['estado']).to eq('APROBADO')
    end

    it 'responds ok if user is inscripted to the subject and disapproved' do
      post_with_body('/calificar', codigo_materia: subject1.code,
                                   notas: '2',
                                   username_alumno: student1.username)

      get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
      expect(JSON.parse(last_response.body)['estado']).to eq('DESAPROBADO')
    end

    it 'responds with a grade' do
      post_with_body('/calificar', codigo_materia: subject1.code,
                                   notas: '10',
                                   username_alumno: student1.username)

      get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject1.code)
      expect(JSON.parse(last_response.body)['nota_final']).to eq(10)
    end

    it 'responds approved when final grade is above 6' do
      post_with_body('/calificar', codigo_materia: subject2.code, notas: '[10, 8]', username_alumno: student1.username)
      get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject2.code)
      expect(JSON.parse(last_response.body)['estado']).to eq('APROBADO')
      expect(JSON.parse(last_response.body)['nota_final']).to eq(9)
    end

    it 'responds disapproved if final grade is less than 6' do
      post_with_body('/calificar', codigo_materia: subject2.code, notas: '[2, 4]', username_alumno: student1.username)
      get_with_token('/materias/estado', usernameAlumno: student1.username, codigoMateria: subject2.code)
      expect(JSON.parse(last_response.body)['estado']).to eq('DESAPROBADO')
      expect(JSON.parse(last_response.body)['nota_final']).to eq(3)
    end
  end
end
