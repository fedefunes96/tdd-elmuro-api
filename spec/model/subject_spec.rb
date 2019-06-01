require 'rspec'
require_relative '../../app/exceptions/student_limit_error'

describe Subject do
  it 'max students has to be at most 300' do
    expect do
      described_class.new('memo2', '9521', 'nicopaez', 500, true, false)
    end.to raise_error(StudentLimitError)
  end

  describe 'attributes' do
    let(:subj) { described_class.new('memo2', '9521', 'NicoPaez', 30, false, false) }

    it 'should respond to teacher' do
      expect(subj.teacher).to eq('NicoPaez')
    end
    it 'should respond to laboratory' do
      expect(subj.laboratory).to eq(false)
    end
    it 'should respond to projector' do
      expect(subj.projector).to eq(false)
    end
  end
end
