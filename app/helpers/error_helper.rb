require_relative '../exceptions/no_available_quota_error'
require_relative '../exceptions/invalid_max_students_error'
require_relative '../exceptions/invalid_subject_settings_error'
require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/duplicate_inscription_error'
require_relative '../../app/exceptions/no_message_found_error'

class ErrorHelper
  ERRORS = {
    NoAvailableQuotaError => 'CUPO_COMPLETO',
    DuplicateInscriptionError => 'INSCRIPCION_DUPLICADA',
    StudentLimitError => 'cupo_excedido',
    InvalidSubjectSettingsError => 'pedidos_incompatibles',
    InvalidMaxStudentsError => 'pedidos_incompatibles'
  }.freeze

  def message(exception)
    raise NoMessageFoundError unless ERRORS.include? exception.class

    ERRORS[exception.class]
  end
end
