require_relative '../model/student'
require_relative '../model/inscription_system'
require_relative '../exceptions/guarani_error'
require_relative '../../repositories/subject_repository'
require_relative '../../repositories/student_repository'
require_relative '../../repositories/inscription_repository'

class InscriptionController
  NAME = 'nombre_completo'.freeze
  USERNAME = 'username_alumno'.freeze
  CODE = 'codigo_materia'.freeze

  SUCCESS_MESSAGE = 'inscripcion_creada'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze
  SUBJECT_MISSING = 'materia_faltante'.freeze

  def create(body)
    return api_response(PARAMETER_MISSING), 400 unless all_params?(body)

    message, status = create_inscription(body)
    [api_response(message), status]
  end

  private

  def create_inscription(body)
    begin
      subject = SubjectRepository.new.find_by_code(body[CODE])

      return SUBJECT_MISSING, 400 if subject.nil?

      student = retrieve_student(body)

      inscriptions = InscriptionRepository.new.all_inscriptions

      inscription_system = InscriptionSystem.new inscriptions

      inscription = inscription_system.create_inscription(student, subject)
    rescue GuaraniError => e
      return error_msg(e), 400
    end
    InscriptionRepository.new.save(inscription)
    [SUCCESS_MESSAGE, 201]
  end

  def retrieve_student(body)
    student = Student.new body[NAME], body[USERNAME]

    StudentRepository.new.save(student)

    student
  end

  def error_msg(error)
    messages = {
      NoAvailableQuotaError => 'CUPO_COMPLETO',
      DuplicateInscriptionError => 'INSCRIPCION_DUPLICADA'
    }

    messages[error.class]
  end

  def all_params?(body)
    body.include?(NAME) && body.include?(CODE) && body.include?(USERNAME)
  end

  def api_response(message)
    { error: message, resultado: message }
  end
end
