class AcademicOfferController
  USERNAME = 'username'.freeze

  def initialize
    subjects = SubjectRepository.new.all_subjects
    inscriptions = InscriptionRepository.new.all_inscriptions
    @inscription_system = InscriptionSystem.new(inscriptions)
    @academic_offer = AcademicOffer.new(subjects, @inscription_system)
    @student_repository = StudentRepository.new
  end

  def handle(params)
    student = @student_repository.find_by_username(params[USERNAME])
    offer = @academic_offer.offer_for(student)
    { oferta: offer.map(&method(:subject_to_hash)) }
  end

  private

  def subject_to_hash(subject)
    {
      codigo: subject.code
    }
  end
end
