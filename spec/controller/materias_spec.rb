require 'rspec'
require 'rack/test'
require_relative '../../app/app'

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
                                modalidad: 'parciales', proyector: true,
                                laboratorio: false)
    expect(last_response.status).to eq 201
  end

  it 'new subject created is persisted on db' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 30,
                                modalidad: 'parciales', proyector: true,
                                laboratorio: false)
    expect(SubjectRepository.new.find_by_code('9521').name).to eq 'memo2'
  end

  it 'responds with error if max students over limit' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 301,
                                modalidad: 'parciales', proyector: true,
                                laboratorio: false)
    expect(last_response.status).to eq 400
  end

  it 'responds with error if subject has projector and laboratory at the same time' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 30,
                                modalidad: 'parciales', proyector: true,
                                laboratorio: true)
    expect(last_response.status).to eq 400
  end

  it 'responds with error if subject with that code already exists' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true, laboratorio: false)
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo1', docente: 'Otro', cupo: 40,
                                modalidad: 'parciales', proyector: true, laboratorio: false)
    expect(last_response.status).to eq 400
  end

  it 'assumes laboratory is not required when not specified' do
    post_with_body('/materias', codigo: '9521', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 201
    expect(SubjectRepository.new.find_by_code('9521').laboratory).to eq false
  end

  it 'responds with error if subject has code longer than 4 characters' do
    post_with_body('/materias', codigo: '10000', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 400
  end

  it 'responds with NOMBRE_ERRONEO if subject name is longer than 50 characters' do
    LONG_NAME = '012345678901234567890123456789012345678901234567890123456789'.freeze
    post_with_body('/materias', codigo: '9521', nombreMateria: LONG_NAME, docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 400
    expect(last_response.body).to include('NOMBRE_ERRONEO')
  end

  it 'responds with NOMBRE_ERRONEO if subject name is less than 1 characters' do
    post_with_body('/materias', codigo: '9521', nombreMateria: '', docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 400
    expect(last_response.body).to include('NOMBRE_ERRONEO')
  end

  it 'responds with CODIGO_ERRONEO if subject code is less than 1 character' do
    post_with_body('/materias', codigo: '', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 40,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 400
    expect(last_response.body).to include('CODIGO_ERRONEO')
  end

  it 'responds with 400 if subject max students is 0' do
    post_with_body('/materias', codigo: '', nombreMateria: 'memo2', docente: 'Nico Paez', cupo: 0,
                                modalidad: 'parciales', proyector: true)
    expect(last_response.status).to eq 400
  end
end
