require_relative '../model/subject'
require_relative '../exceptions/guarani_error'
require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'
require_relative '../helpers/parameter_helper'
require_relative '../helpers/status_code'
require_relative '../helpers/error_helper'
require_relative '../helpers/subject_type_parser'

class SubjectController
  PARAMS = {
    name: 'nombreMateria',
    code: 'codigo',
    teacher: 'docente',
    max_students: 'cupo',
    type: 'modalidad'
  }.freeze

  PROJECTOR = 'proyector'.freeze
  LABORATORY = 'laboratorio'.freeze
  SUCCESS_MESSAGE = 'materia_creada'.freeze
  CODE_NOT_UNIQUE = 'MATERIA_DUPLICADA'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze

  def create(body)
    unless ParameterHelper.new(PARAMS).all_params?(body)
      return api_response(PARAMETER_MISSING, StatusCode::BAD_REQUEST)
    end

    if code_already_exists? body[PARAMS[:code]]
      return api_response(CODE_NOT_UNIQUE,
                          StatusCode::BAD_REQUEST)
    end

    message, status = create_subject(body)
    api_response(message, status)
  end

  private

  def create_subject(body)
    begin
      subject = create_subject_from_body(body)
    rescue GuaraniError => e
      return ErrorHelper.new.message(e), StatusCode::BAD_REQUEST
    end
    SubjectRepository.new.save(subject)
    [SUCCESS_MESSAGE, StatusCode::CREATED]
  end

  def create_subject_from_body(body)
    projector = body[PROJECTOR] || false
    laboratory = body[LABORATORY] || false

    Subject.new(body[PARAMS[:name]], body[PARAMS[:code]], body[PARAMS[:teacher]],
                body[PARAMS[:max_students]], projector, laboratory, subject_type(body))
  end

  def map_setting_to_boolean(value)
    return false if value.nil?

    {
      'si': true,
      'no': false
    }[value.to_sym]
  end

  def code_already_exists?(code)
    !SubjectRepository.new.find_by_code(code).nil?
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

  def subject_type(body)
    type = body[PARAMS[:type]]
    SubjectTypeParser.new.parse(type)
  end
end
