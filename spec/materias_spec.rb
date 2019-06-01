require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Alta materias' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'accepts a post to /materias' do
    post_with_body('/materias', {})
    expect(last_response.status).not_to eq 404
  end

  it 'creates a new subject' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 30,
                                modalidad: 'parciales', con_proyector: 'si',
                                con_laboratorio: 'no')
    expect(last_response.status).to eq 201
  end

  it 'new subject created is persisted on db' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 30,
                                modalidad: 'parciales', con_proyector: 'si',
                                con_laboratorio: 'no')
    expect(SubjectRepository.new.find_by_code('9521').name).to eq 'memo2'
  end
end
