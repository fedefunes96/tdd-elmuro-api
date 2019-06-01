require 'sinatra'
require 'json'
require_relative 'model/subject'
require_relative '../repositories/subject_repository'

post '/materias' do
  content_type :json
end
