require_relative '../model/student'
require_relative '../model/inscription_system'
require_relative '../exceptions/guarani_error'
require_relative '../../repositories/subject_repository'
require_relative '../../repositories/student_repository'
require_relative '../../repositories/inscription_repository'
require_relative '../helpers/parameter_helper'
require_relative '../helpers/status_code'
require_relative '../helpers/error_helper'

class InscriptionController
  PARAMS = {
    name: 'nombre_completo',
    code: 'codigo_materia',
    username: 'username_alumno'
  }.freeze

  SUCCESS_MESSAGE = 'INSCRIPCION_CREADA'.freeze
  PARAMETER_MISSING = 'PARAMETRO_FALTANTE'.freeze
  SUBJECT_MISSING = 'MATERIA_NO_EXISTE'.freeze

  def create(body)
    unless ParameterHelper.new(PARAMS).all_params?(body)
      return api_response(PARAMETER_MISSING, StatusCode::BAD_REQUEST)
    end

    message, status = create_inscription(body[PARAMS[:name]],
                                         body[PARAMS[:code]],
                                         body[PARAMS[:username]])
    api_response(message, status)
  end

  private

  def create_inscription(name, code, username)
    subject = SubjectRepository.new.find_by_code(code)

    return SUBJECT_MISSING, StatusCode::BAD_REQUEST if subject.nil?

    student = retrieve_student(name, username)

    inscriptions = InscriptionRepository.new.all_inscriptions

    inscription_system = InscriptionSystem.new inscriptions

    begin
      inscription = inscription_system.create_inscription(student, subject)
    rescue GuaraniError => e
      return ErrorHelper.new.message(e), StatusCode::BAD_REQUEST
    end
    InscriptionRepository.new.save(inscription)
    [SUCCESS_MESSAGE, StatusCode::CREATED]
  end

  def retrieve_student(name, username)
    student = Student.new name, username

    StudentRepository.new.save(student)

    student
  end

  def api_response(message, status)
    key = if status == StatusCode::BAD_REQUEST
            'error'
          else
            'resultado'
          end

    response = {}
    response[key] = message
    [response, status]
  end
end
