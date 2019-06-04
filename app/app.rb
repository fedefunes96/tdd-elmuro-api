require 'sinatra'
require 'json'
require_relative 'controller/subject_controller'
require_relative '../repositories/subject_repository'

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
  { respuesta: 'ok' }.to_json
end
