require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'

class Subject
  MAX_STUDENTS_LIMIT = 300
  attr_accessor :name, :code, :max_students, :teacher, :projector, :laboratory

  def initialize(name, code, teacher, max_students, projector, laboratory)
    validate_settings(projector, laboratory)
    validate_max_students(max_students)
    @name = name
    @code = code
    @teacher = teacher
    @max_students = max_students
    @projector = projector
    @laboratory = laboratory
  end

  private

  def validate_max_students(max_students)
    raise StudentLimitError if max_students > MAX_STUDENTS_LIMIT
  end

  def validate_settings(projector, laboratory)
    msg = 'Subject can not have projector and laboratory at the same time'
    raise(InvalidSubjectSettingsError, msg) if projector && laboratory
  end
end
