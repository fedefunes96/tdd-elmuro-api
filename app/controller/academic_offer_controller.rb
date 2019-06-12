require_relative '../../repositories/subject_repository'
require_relative '../../repositories/inscription_repository'
require_relative '../../repositories/student_repository'
require_relative '../../app/model/academic_offer'
require_relative '../../app/model/inscription_system'

class AcademicOfferController
  SUBJECT_TYPES = {
    finals: 'coloquio',
    midterms: 'parciales'
  }.freeze

  USERNAME = 'usernameAlumno'.freeze

  def initialize
    subjects = SubjectRepository.new.all_subjects
    inscriptions = InscriptionRepository.new.all_inscriptions
    @inscription_system = InscriptionSystem.new(inscriptions)
    @academic_offer = AcademicOffer.new(subjects, @inscription_system)
    @student_repository = StudentRepository.new
  end

  def handle(params)
    student = @student_repository.find_by_username(params[USERNAME])
    offer = if student.nil?
              @academic_offer.all_subjects
            else
              @academic_offer.offer_for(student)
            end
    { oferta: offer.map(&method(:subject_to_hash)) }
  end

  private

  def subject_to_hash(subject)
    {
      codigo: subject.code,
      nombre: subject.name,
      docente: subject.teacher,
      cupo: @inscription_system.remaining_slots(subject),
      modalidad: SUBJECT_TYPES[subject.type]
    }
  end
end
