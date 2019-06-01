require_relative '../model/subject'
require_relative '../exceptions/guarani_error'
require_relative '../exceptions/student_limit_error'

class SubjectController
  NAME = 'nombreMateria'.freeze
  CODE = 'codigo'.freeze
  TEACHER = 'docente'.freeze
  MAX_STUDENTS = 'cupo'.freeze
  PROJECTOR = 'con_proyector'.freeze
  LABORATORY = 'con_laboratorio'.freeze

  def create(body)
    status_code = 400
    return 'parametro_faltante', 400 unless all_params?(body)

    message = create_subject(body)
    status_code = 201 if message.nil?
    message = 'materia_creada' if message.nil?
    [message, status_code]
  end

  private

  def create_subject(body)
    parse_setting_fields(body)
    begin
      subject = Subject.new(body[NAME], body[CODE], body[TEACHER],
                            body[MAX_STUDENTS], body[PROJECTOR], body[LABORATORY])
    rescue GuaraniError => e
      return error_msg(e)
    end
    SubjectRepository.new.save(subject)
    nil
  end

  def all_params?(body)
    body.include?(NAME) && body.include?(CODE) && body.include?(MAX_STUDENTS)
  end

  def error_msg(error)
    messages = {
      StudentLimitError => 'cupo_excedido'
    }

    messages[error.class]
  end

  def parse_setting_fields(body)
    body[PROJECTOR] = map_setting_to_boolean(body[PROJECTOR])
    body[LABORATORY] = map_setting_to_boolean(body[LABORATORY])
  end

  def map_setting_to_boolean(value)
    {
      'si': true,
      'no': false
    }[value]
  end
end
