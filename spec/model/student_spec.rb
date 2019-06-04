require 'rspec'
require_relative '../../app/model/student'

describe Student do
  let(:student) { described_class.new('Juan Perez') }

  describe 'attributes' do
    it 'should respond to name' do
      expect(student.name).to eq('Juan Perez')
    end
  end
end
