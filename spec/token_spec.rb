require 'rspec'
require 'rack/test'
require_relative '../config/token'

describe 'API Token' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'returns status 401 if token does not match' do
    header 'Api-Token', 'wrong_token'
    post('/any_endpoint')
    expect(last_response.status).to eq 401
  end

  it 'returns different than 401 if token matches' do
    header 'Api-Token', TOKEN
    post('/any_endpoint')
    expect(last_response.status).not_to eq 401
  end

  it 'returns error message when token is invalid' do
    header 'Api-Token', 'wrong_token'
    post('/any_endpoint')
    expect(last_response.body['error'].nil?).to eq false
  end

  it 'returns error message when token is not supplied' do
    post('/any_endpoint')
    expect(last_response.body['error'].nil?).to eq false
  end
end
