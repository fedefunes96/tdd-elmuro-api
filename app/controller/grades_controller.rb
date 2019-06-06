require 'json'
require_relative '../helpers/status_code'
require_relative '../../repositories/inscription_repository'

class GradesController
  PARAMS = {
    code: 'codigo_materia',
    username: 'username_alumno',
    grades: 'notas'
  }.freeze

  SUCCESS_MESSAGE = 'notas_creadas'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze
  INVALID_CODE = 'codigo_invalido'.freeze
  GRADE_ERROR = 'nota_invalida'.freeze

  def initialize
    @inscription_repository = InscriptionRepository.new
  end

  def grade(body)
    unless ParameterHelper.new(PARAMS).all_params?(body)
      return api_response(PARAMETER_MISSING, StatusCode::BAD_REQUEST)
    end

    update_grades(body)
  end

  private

  def update_grades(body)
    inscription = @inscription_repository
                  .find_by_student_and_code(body[PARAMS[:username]], body[PARAMS[:code]])

    return api_response(INVALID_CODE, StatusCode::BAD_REQUEST) if inscription.nil?

    grades = parse_grades(body[PARAMS[:grades]])
    begin
      inscription.add_grades(grades)
    rescue GuaraniError
      return api_response(GRADE_ERROR, StatusCode::BAD_REQUEST)
    end
    @inscription_repository.save(inscription)
    [{ resultado: SUCCESS_MESSAGE }, StatusCode::OK]
  end

  def parse_grades(grades)
    [Integer(grades)]
  rescue ArgumentError
    JSON.parse(grades)
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
