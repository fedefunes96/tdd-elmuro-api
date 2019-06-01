require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Alta materias' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'accepts a post to /materias' do
    post '/materias'
    expect(last_response.status).not_to eq 404
  end
end
