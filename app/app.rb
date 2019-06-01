require 'sinatra'
require 'json'
require_relative 'model/subject'
require_relative '../repositories/subject_repository'

post '/materias' do
  content_type :json
  status 201
  body = JSON.parse(request.body.read)
  subject = Subject.new(body['nombre'], body['codigo'])
  SubjectRepository.new.save(subject)
  { resultado: 'materia_creada' }.to_json
end
