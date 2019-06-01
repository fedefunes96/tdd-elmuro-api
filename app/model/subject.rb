require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'

class Subject
  attr_accessor :name, :code, :max_students, :teacher, :projector, :laboratory

  def initialize(name, code, teacher, max_students, projector, laboratory)
    validate_max_students(max_students)
    validate_settings(projector, laboratory)
    @name = name
    @code = code
    @teacher = teacher
    @max_students = max_students
    @projector = projector
    @laboratory = laboratory
  end

  private

  def validate_max_students(max_students)
    raise(StudentLimitError, "max_students over limit: #{max_students}") if max_students > 300
  end

  def validate_settings(projector, laboratory)
    msg = 'Subject can not have projector and laboratory at the same time'
    raise(InvalidSubjectSettingsError, msg) if projector && laboratory
  end
end
