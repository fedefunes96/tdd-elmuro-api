require 'rspec'
require_relative '../../app/helpers/subject_type_parser'

describe SubjectTypeParser do
  it 'returns :finals for coloquio' do
    expect(described_class.new.parse('coloquio')).to eq :finals
  end

  it 'returns :assignments for tareas' do
    expect(described_class.new.parse('tareas')).to eq :assignments
  end

  it 'returns :midterms for parciales' do
    expect(described_class.new.parse('parciales')).to eq :midterms
  end

  it 'returns nil when type is not found' do
    expect(described_class.new.parse('invalid').nil?). to eq true
  end
end
