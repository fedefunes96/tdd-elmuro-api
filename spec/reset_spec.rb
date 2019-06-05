require 'rspec'
require 'rack/test'
require_relative '../app/app'
require_relative 'spec_helper'

describe 'reset' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'reset deletes all subjects' do
    SubjectRepository.new.save(Subject.new('memo2', '9521', 'nicopaez', 50, true, false))
    post_with_body('/reset', {})
    expect(SubjectRepository.new.find_by_code('9521')).to eq nil
  end
end
