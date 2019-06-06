require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Grades endpoint' do
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
end
