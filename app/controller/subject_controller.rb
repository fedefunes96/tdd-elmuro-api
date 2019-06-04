require_relative '../model/subject'
require_relative '../exceptions/guarani_error'
require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'

class SubjectController
  NAME = 'nombreMateria'.freeze
  CODE = 'codigo'.freeze
  TEACHER = 'docente'.freeze
  MAX_STUDENTS = 'cupo'.freeze
  PROJECTOR = 'proyector'.freeze
  LABORATORY = 'laboratorio'.freeze

  SUCCESS_MESSAGE = 'materia_creada'.freeze
  CODE_NOT_UNIQUE = 'MATERIA_DUPLICADA'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze

  def create(body)
    return api_response(PARAMETER_MISSING), 400 unless all_params?(body)

    return api_response(CODE_NOT_UNIQUE), 400 if code_already_exists? body[CODE]

    message, status = create_subject(body)
    [api_response(message), status]
  end

  private

  def create_subject(body)
    begin
      projector = body[PROJECTOR] || false
      laboratory = body[LABORATORY] || false
      subject = Subject.new(body[NAME], body[CODE], body[TEACHER],
                            body[MAX_STUDENTS], projector, laboratory)
    rescue GuaraniError => e
      return error_msg(e), 400
    end
    SubjectRepository.new.save(subject)
    [SUCCESS_MESSAGE, 201]
  end

  def all_params?(body)
    body.include?(NAME) && body.include?(CODE) && body.include?(MAX_STUDENTS)
  end

  def error_msg(error)
    messages = {
      StudentLimitError => 'cupo_excedido',
      InvalidSubjectSettingsError => 'pedidos_incompatibles'
    }

    messages[error.class]
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

  def api_response(message)
    { error: message, resultado: message }
  end
end
