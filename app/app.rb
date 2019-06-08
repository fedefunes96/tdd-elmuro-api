require 'sinatra'
require 'json'
require_relative 'controller/subject_controller'
require_relative 'controller/inscription_controller'
require_relative 'controller/grades_controller'
require_relative '../repositories/student_repository'
require_relative '../repositories/inscription_repository'
require_relative '../repositories/subject_repository'
require_relative '../config/token'

before do
  token = request.get_header('HTTP_API_TOKEN')
  path = request.path
  halt 401 if token != TOKEN && path != '/reset'
end

post '/materias' do
  content_type :json
  status 201
  body = JSON.parse(request.body.read)
  message, status_code = SubjectController.new.create(body)
  status status_code
  message.to_json
end

post '/reset' do
  SubjectRepository.new.delete_all
  InscriptionRepository.new.delete_all
  StudentRepository.new.delete_all
  { respuesta: 'ok' }.to_json
end

post '/alumnos' do
  content_type :json
  body = JSON.parse(request.body.read)
  message, status_code = InscriptionController.new.create(body)
  status status_code
  message.to_json
end

post '/calificar' do
  content_type :json
  body = JSON.parse(request.body.read)
  message, status_code = GradesController.new.grade(body)
  status status_code
  message.to_json
end

get '/materias' do
  status 200
  { oferta: [] }.to_json
end
