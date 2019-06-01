require_relative '../exceptions/student_limit_error'

class Subject
  attr_accessor :name, :code, :max_students, :teacher, :projector, :laboratory

  def initialize(name, code, teacher, max_students, projector, laboratory)
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
    raise(StudentLimitError, "max_students over limit: #{max_students}") if max_students > 300
  end
end
