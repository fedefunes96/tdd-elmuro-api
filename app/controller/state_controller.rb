require_relative '../model/student'
require_relative '../model/inscription_system'
require_relative '../exceptions/guarani_error'
require_relative '../../repositories/subject_repository'
require_relative '../../repositories/student_repository'
require_relative '../../repositories/inscription_repository'
require_relative '../helpers/parameter_helper'
require_relative '../helpers/status_code'
require_relative '../helpers/error_helper'

class StateController
  PARAMS = {
    username: 'usernameAlumno',
    code: 'codigoMateria'
  }.freeze

  NOT_INSCRIPTED = 'no_inscripto'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze
  SUBJECT_NOT_EXISTS = 'materia_inexistente'.freeze
  INSCRIPTED = 'inscripto'.freeze

  def state(params)
    unless ParameterHelper.new(PARAMS).all_params?(params)
      return api_response(PARAMETER_MISSING), StatusCode::BAD_REQUEST
    end

    message, status = retrieve_state(params[PARAMS[:username]],
                                     params[PARAMS[:code]])
    [api_response(message), status]
  end

  private

  def api_response(message)
    { estado: message }
  end

  def retrieve_state(username, code)
    subject = SubjectRepository.new.find_by_code(code)

    return [SUBJECT_NOT_EXISTS, StatusCode::BAD_REQUEST] if subject.nil?

    student = StudentRepository.new.find_by_username(username)
    inscriptions = InscriptionRepository.new.all_inscriptions

    inscription_system = InscriptionSystem.new inscriptions

    return [NOT_INSCRIPTED, StatusCode::OK] if not_inscripted?(student, subject, inscription_system)

    [INSCRIPTED, StatusCode::OK]
  end

  def not_inscripted?(student, subject, inscription_system)
    student.nil? || !inscription_system.inscripted_to?(student, subject)
  end
end
