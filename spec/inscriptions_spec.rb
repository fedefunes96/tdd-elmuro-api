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

  it 'creates a new inscription' do
    post_with_body('/inscribir', nombre_completo: 'Juan Perez',
                                 username_alumno: 'juanperez', codigo_materia: '7592')
    expect(last_response.status).to eq 201
  end
end
