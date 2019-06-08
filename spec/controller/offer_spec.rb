require 'rspec'
require 'rack/test'
require_relative '../../app/app'
require_relative '../spec_helper'

describe 'Alta materias' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should respond with status code different than 404' do
    get_with_token('/materias', username: 'juanperez')
    expect(last_response.status).not_to eq 404
  end

  it 'should respond with a subject list' do
    get_with_token('/materias', username: 'juanperez')
    expect(JSON.parse(last_response.body)['oferta'].class).to eq Array
  end

  describe 'subject responses' do
    let(:student) { Student.new('Juan Perez', 'juanperez') }
    let(:subject1) { Subject.new('Tecnicas 2', '7592', 'NicoPaez', 10, true, false) }

    before(:each) do
      SubjectRepository.new.save(subject1)
      InscriptionRepository.new.save(Inscription.new(student, subject1))
    end

    it 'subject should have a code' do
      get_with_token('/materias', username: 'juanperez')
      subjects = JSON.parse(last_response.body)['oferta']
      expect(subjects.first['codigo']).to eq subject1.code
    end

    it 'subject should have a name' do
      get_with_token('/materias', username: 'juanperez')
      subjects = JSON.parse(last_response.body)['oferta']
      expect(subjects.first['nombre']).to eq subject1.name
    end

    it 'subject should have a teacher' do
      get_with_token('/materias', username: 'juanperez')
      subjects = JSON.parse(last_response.body)['oferta']
      expect(subjects.first['docente']).to eq subject1.teacher
    end

    it 'subject should have a quota number' do
      get_with_token('/materias', username: 'juanperez')
      subjects = JSON.parse(last_response.body)['oferta']
      expect(subjects.first['cupo']).to eq subject1.max_students
    end
  end
end
