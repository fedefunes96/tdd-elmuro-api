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

  NOT_INSCRIPTED = 'NO_INSCRIPTO'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze
  INSCRIPTED = 'EN_CURSO'.freeze
  APROBADO = 'APROBADO'.freeze
  DESAPROBADO = 'DESAPROBADO'.freeze

  def state(params)
    unless ParameterHelper.new(PARAMS).all_params?(params)
      return error_response(PARAMETER_MISSING), StatusCode::BAD_REQUEST
    end

    message, grade = retrieve_state(params[PARAMS[:username]],
                                    params[PARAMS[:code]])
    [api_response(message, grade), StatusCode::OK]
  end

  private

  def error_response(message)
    { error: message }
  end

  def api_response(message, grade)
    return { estado: message } if grade.nil?

    { estado: message, nota_final: grade }
  end

  def retrieve_state(username, code)
    inscription = InscriptionRepository.new
                                       .find_by_student_and_code(username, code)

    return [NOT_INSCRIPTED, nil] if inscription.nil?

    return [INSCRIPTED, nil] unless inscription.graded?

    grade = inscription.final_grade

    return [DESAPROBADO, grade] unless inscription.passing?

    [APROBADO, grade]
  end
end
