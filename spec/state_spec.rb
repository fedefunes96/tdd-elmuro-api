require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Estado alumno' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'accepts a get to /estado' do
    get_with_body('/estado', {})
    expect(last_response.status).not_to eq 404
  end
end
