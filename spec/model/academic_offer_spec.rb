require 'rspec'

require_relative '../../app/model/academic_offer'
require_relative '../../app/model/student'
require_relative '../../app/model/subject'
require_relative '../../app/model/inscription_system'

describe AcademicOffer do
  let(:subject1) { Subject.new('memo2', '9521', 'NicoPaez', 30, false, false) }
  let(:subject2) { Subject.new('memo1', '9520', 'SergioVi', 30, false, false) }
  let(:student) { Student.new('Juan Perez', 'juanperez') }
  let(:inscription_system) { InscriptionSystem.new }

  let(:academic_offer) { described_class.new([subject1, subject2], inscription_system) }

  it 'initially offer for a student is all subjects' do
    offer = academic_offer.offer_for(student)
    expect(offer.include?(subject1)).to eq true
    expect(offer.include?(subject2)).to eq true
  end

  it 'if a student signs up on a subject, it still shows up on the offer' do
    inscription_system.create_inscription(student, subject1)
    offer = academic_offer.offer_for(student)
    expect(offer.include?(subject1)).to eq true
  end
end
