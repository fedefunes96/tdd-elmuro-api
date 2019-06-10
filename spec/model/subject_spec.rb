require 'rspec'
require_relative '../../app/exceptions/student_limit_error'
require_relative '../../app/exceptions/invalid_max_students_error'
require_relative '../../app/exceptions/invalid_subject_code_error'
require_relative '../../app/exceptions/invalid_subject_name_error'

describe Subject do
  it 'max students has to be at most 300' do
    expect do
      described_class.new('memo2', '9521', 'nicopaez', 500, true, false, :finals)
    end.to raise_error(StudentLimitError)
  end

  describe 'attributes' do
    let(:subj) { described_class.new('memo2', '9521', 'NicoPaez', 30, false, false, :midterms) }

    it 'should respond to teacher' do
      expect(subj.teacher).to eq('NicoPaez')
    end
    it 'should respond to laboratory' do
      expect(subj.laboratory).to eq(false)
    end
    it 'should respond to projector' do
      expect(subj.projector).to eq(false)
    end

    it 'should respond to type' do
      expect(subj.type).to eq :midterms
    end
  end

  it 'can not have projector and laboratory at the same time' do
    expect do
      described_class.new('memo2', '9521', 'NicoPaez', 30, true, true, :finals)
    end.to raise_error(InvalidSubjectSettingsError)
  end

  it 'can not have negative max students' do
    expect do
      described_class.new('memo2', '9521', 'NicoPaez', -30, false, false, :finals)
    end.to raise_error(InvalidMaxStudentsError)
  end

  it 'subject code can not be over 4 characters long' do
    expect do
      described_class.new('memo2', '10000', 'NicoPaez', 30, false, false, :finals)
    end.to raise_error(InvalidSubjectCodeError)
  end

  it 'should raise error when subject name is longer than 50 characters' do
    expect do
      LONG_NAME = '012345678901234567890123456789012345678901234567890123456789'.freeze
      described_class.new(LONG_NAME, '9521', 'NicoPaez', 30, false, false, :finals)
    end.to raise_error(InvalidSubjectNameError)
  end

  it 'subject is equal to another if they share the same code' do
    one_subject = described_class.new('memo2', '9521', 'NicoPaez', 30, false, false, :finals)
    other = described_class.new('memo2', '9521', 'NicoPaez', 30, false, false, :finals)
    expect(one_subject == other).to eq true
  end

  it 'subject is not equal to another if they have different code' do
    one_subject = described_class.new('memo2', '9521', 'NicoPaez', 30, false, false, :finals)
    other = described_class.new('memo2', '5221', 'NicoPaez', 30, false, false, :finals)
    expect(one_subject == other).to eq false
  end

  it 'should allow subject type to be :finals' do
    described_class.new('memo2', '1000', 'NicoPaez', 30, false, false, :finals)
  end

  it 'should allow subject type to be :midterms' do
    described_class.new('memo2', '1000', 'NicoPaez', 30, false, false, :midterms)
  end

  it 'should allow subject type to be :assignments' do
    described_class.new('memo2', '1000', 'NicoPaez', 30, false, false, :assignments)
  end
end
