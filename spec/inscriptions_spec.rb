require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Inscripcion alumnos' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'accepts a post to /inscribir' do
    post_with_body('/inscribir', {})
    expect(last_response.status).not_to eq 404
  end
end
