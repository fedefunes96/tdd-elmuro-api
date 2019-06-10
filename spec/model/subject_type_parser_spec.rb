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
end
