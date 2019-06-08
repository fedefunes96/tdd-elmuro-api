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
    get_with_token('/materias')
    expect(last_response.status).not_to eq 404
  end
end
