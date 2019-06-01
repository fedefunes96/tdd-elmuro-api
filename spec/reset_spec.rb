require 'rspec'
require 'rack/test'
require_relative '../app/app'

describe 'reset' do
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  it 'reset deletes all subjects' do
    SubjectRepository.new.save(Subject.new('memo2', '9521'))
    post '/reset'
    expect(SubjectRepository.new.find_by_code('9521')).to eq nil
  end
end
