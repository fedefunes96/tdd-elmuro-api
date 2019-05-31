require 'sinatra'
require 'json'
require_relative 'model/health'
require 'sequel'
require 'yaml'

get '/health' do
  content_type :json
  # input = JSON.parse(request.body.read)

  health = Health.new

  status 200
  { status: health.status }.to_json
end
