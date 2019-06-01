require 'sinatra'
require 'json'
require_relative 'controller/subject_controller'

post '/materias' do
  content_type :json
  status 201
  SubjectController.new.create(request.body.read)
end
