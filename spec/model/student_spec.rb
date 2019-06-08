require 'rspec'
require_relative '../../app/model/student'

describe Student do
  let(:student) { described_class.new('Juan Perez', 'juanperez') }

  describe 'attributes' do
    it 'should respond to name' do
      expect(student.name).to eq('Juan Perez')
    end

    it 'should respond to username' do
      expect(student.username).to eq('juanperez')
    end
  end

  it 'students with the same username should be equal' do
    other = described_class.new('Juan Perez', 'juanperez')
    expect(student == other).to eq true
  end

  it 'students with different username should not be considered equal' do
    other = described_class.new('Juan Perez', 'juanperez2')
    expect(student == other).to eq false
  end
end
