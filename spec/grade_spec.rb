require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'Grades endpoint' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'accepts a post to grades endpoint' do
    post_with_body('/calificar', codigo_materia: '1001',
                                 notas: '[4,6,8,1]',
                                 username_alumno: 'juanperez')

    expect(last_response.status).not_to eq 404
  end
end
