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

  it 'creates a new subject' do
    post('/materias', codigo: 9521, nombre: 'memo2', docente: 'Nico Paez',
                      cupo: 'parciales', con_proyector: 'si', con_laboratorio: 'no')
    expect(last_response.status).to eq 201
  end
end
