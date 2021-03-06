require 'rspec'
require 'rack/test'
require_relative '../../app/app'

describe 'Grades endpoint' do
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
  let(:inscription) do
    inscription = Inscription.new(student1, subject1)
    inscription
  end
  let(:subject2) do
    subject2 = Subject.new('Memo2', '2020', 'NicoPaez', 15, true, false, :midterms)
    SubjectRepository.new.save(subject2)
    subject2
  end
  let(:inscription2) do
    inscription2 = Inscription.new(student1, subject2)
    inscription2
  end

  def app
    Sinatra::Application
  end

  it 'accepts a post to grades endpoint' do
    InscriptionRepository.new.save(inscription)
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '[4,6,8,1]',
                                 username_alumno: 'juanperez')

    expect(last_response.status).not_to eq 404
  end

  it 'updates an existing inscription with grades' do
    InscriptionRepository.new.save(inscription)
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '[10]',
                                 username_alumno: 'juanperez')

    expect(InscriptionRepository.new.all_inscriptions.first.passing?).to eq true
  end

  it 'accepts a single number as a grade' do
    InscriptionRepository.new.save(inscription)
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '10',
                                 username_alumno: 'juanperez')

    expect(InscriptionRepository.new.all_inscriptions.first.passing?).to eq true
  end

  it 'returns 400 if code missing' do
    InscriptionRepository.new.save(inscription)
    post_with_body('/calificar',
                   notas: '10',
                   username_alumno: 'juanperez')

    expect(last_response.status).to eq 400
  end

  it 'returns 400 if subject with that code does not exist' do
    SubjectRepository.new.delete_all
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '10',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if username does not exist' do
    StudentRepository.new.delete_all
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '10',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if an invalid grade is passed' do
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '-10',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if grade is not numeric' do
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: 'string',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if grade is empty array' do
    InscriptionRepository.new.save(inscription)
    post_with_body('/calificar', codigo_materia: '1001', notas: '[]',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
    expect(last_response.body).to include('NOTA_INVALIDA')
  end

  it 'returns 200 if grades are ok for midterm subject' do
    InscriptionRepository.new.save(inscription2)
    post_with_body('/calificar', codigo_materia: '2020', notas: '[10, 8]',
                                 username_alumno: 'juanperez')
    expect(last_response.body).to include('notas_creadas')
    expect(last_response.status).to eq 200
  end

  it 'returns 400 if a grade is above 10 for midterm subject' do
    InscriptionRepository.new.save(inscription2)
    post_with_body('/calificar', codigo_materia: '2020', notas: '[20, 8]',
                                 username_alumno: 'juanperez')
    expect(last_response.body).to include('NOTA_INVALIDA')
    expect(last_response.status).to eq 400
  end

  it 'return 400 if more than 2 grades is passed for midterm subject' do
    InscriptionRepository.new.save(inscription2)
    post_with_body('/calificar', codigo_materia: '2020', notas: '[4, 6, 8, 10]',
                                 username_alumno: 'juanperez')
    expect(last_response.body).to include('NOTA_INVALIDA')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if grades field is empty' do
    InscriptionRepository.new.save(inscription2)
    post_with_body('/calificar', codigo_materia: '2020', notas: '',
                                 username_alumno: 'juanperez')
    expect(last_response.body).to include('NOTA_INVALIDA')
    expect(last_response.status).to eq 400
  end

  it 'returns 400 if student is not enrolled in subject' do
    post_with_body('/calificar', codigo_materia: '2020', notas: '[10,4]',
                                 username_alumno: 'juanperez')
    expect(last_response.status).to eq 400
    expect(JSON.parse(last_response.body)['error']).to eq 'ALUMNO_INCORRECTO'
  end
end
