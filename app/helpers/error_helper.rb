require_relative '../exceptions/no_available_quota_error'
require_relative '../exceptions/invalid_max_students_error'
require_relative '../exceptions/invalid_subject_settings_error'
require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/duplicate_inscription_error'
require_relative '../exceptions/no_message_found_error'
require_relative '../exceptions/invalid_subject_code_error'
require_relative '../exceptions/invalid_subject_name_error'
require_relative '../exceptions/invalid_subject_type_error'
require_relative '../exceptions/invalid_quota_error'

class ErrorHelper
  ERRORS = {
    NoAvailableQuotaError => 'CUPO_COMPLETO',
    DuplicateInscriptionError => 'INSCRIPCION_DUPLICADA',
    StudentLimitError => 'CUPO_EXCEDIDO',
    InvalidSubjectSettingsError => 'PEDIDOS_INCOMPATIBLES',
    InvalidMaxStudentsError => 'PEDIDOS_INCOMPATIBLES',
    InvalidSubjectCodeError => 'CODIGO_ERRONEO',
    InvalidSubjectNameError => 'NOMBRE_ERRONEO',
    InvalidSubjectTypeError => 'MODALIDAD_ERRONEA',
    InvalidQuotaError => 'CUPO_ERRONEO'
  }.freeze

  def message(exception)
    raise NoMessageFoundError unless ERRORS.include? exception.class

    ERRORS[exception.class]
  end
end
