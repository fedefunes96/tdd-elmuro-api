require 'rspec'
require_relative '../../app/helpers/subject_type_parser'

describe SubjectTypeParser do
  it 'returns :finals for coloquio' do
    expect(described_class.new.parse('coloquio')).to eq :finals
  end
end
