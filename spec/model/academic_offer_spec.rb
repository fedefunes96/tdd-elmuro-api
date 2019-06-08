require 'rspec'

require_relative '../../app/model/academic_offer'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'

describe AcademicOffer do
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }
  let(:subject2) { Subject.new('memo1', '9520', 'SergioVi', 30, false, false) }
  let(:student) { Student.new('Juan Perez', 'juanperez') }

  it 'initially offer for a student is all subjects' do
    offer = described_class.new([subject1, subject2]).offer_for(student)
    expect(offer.include?(subject1)).to eq true
    expect(offer.include?(subject2)).to eq true
  end
end
