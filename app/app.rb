require 'sinatra'
require 'json'
require_relative 'model/subject'
require_relative '../repositories/subject_repository'
require_relative '../config/token'

before do
  token = request.get_header('HTTP_API_TOKEN')
  halt 401 unless token == TOKEN
end

post '/subject' do
  content_type :json
  input = JSON.parse(request.body.read)

  repository = SubjectRepository.new

  repository.save(Subject.new(input['name'], input['code']))

  subject = repository.find_by_code(input['code'])

  status 201
  { name: subject.name, code: subject.code }.to_json
end
