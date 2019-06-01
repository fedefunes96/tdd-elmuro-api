require_relative '../exceptions/student_limit_error'

class Subject
  attr_accessor :name, :code, :max_students

  def initialize(name, code, max_students)
    validate_max_students(max_students)
    @name = name
    @code = code
    @max_students = max_students
  end

  private

  def validate_max_students(max_students)
    raise(StudentLimitError, "max_students over limit: #{max_students}") if max_students > 300
  end
end
