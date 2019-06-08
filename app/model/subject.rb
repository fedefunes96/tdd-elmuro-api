require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'
require_relative '../exceptions/invalid_max_students_error'

class Subject
  MAX_STUDENTS_LIMIT = 300
  MAX_CODE_LENGTH = 4
  attr_accessor :name, :code, :max_students, :teacher, :projector, :laboratory

  def initialize(name, code, teacher, max_students, projector, laboratory)
    validate_params!(code, laboratory, max_students, projector)
    @name = name
    @code = code
    @teacher = teacher
    @max_students = max_students
    @projector = projector
    @laboratory = laboratory
  end

  private

  def validate_params!(code, laboratory, max_students, projector)
    validate_settings(projector, laboratory)
    validate_max_students(max_students)
    validate_code(code)
  end

  def validate_code(code)
    raise InvalidSubjectCodeError if code.length > MAX_CODE_LENGTH
  end

  def validate_max_students(max_students)
    raise InvalidMaxStudentsError if max_students.negative?

    raise StudentLimitError if max_students > MAX_STUDENTS_LIMIT
  end

  def validate_settings(projector, laboratory)
    msg = 'Subject can not have projector and laboratory at the same time'
    raise(InvalidSubjectSettingsError, msg) if projector && laboratory
  end
end
