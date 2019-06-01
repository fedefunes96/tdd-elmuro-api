require 'sinatra'
require 'json'
require_relative 'controller/subject_controller'
require_relative '../repositories/subject_repository'

post '/materias' do
  content_type :json
  status 201
  SubjectController.new.create(request.body.read)
end

post '/reset' do
  SubjectRepository.new.delete_all
  { respuesta: 'ok' }.to_json
end
