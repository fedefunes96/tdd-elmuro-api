require_relative '../../app/exceptions/invalid_grade_error'

class Inscription
  PASSING_GRADE = 4
  MAX_GRADE = 10

  attr_accessor :student, :subject, :grades

  def initialize(student, subject)
    @student = student
    @subject = subject
    @grades = []
  end

  def ==(other)
    @student.username == other.student.username &&
      @subject.code == other.subject.code
  end

  def add_grades(grades)
    grades.each { |x| raise InvalidGradeError if not_valid_grade? x }
    @grades = grades
  end

  def passing?
    return false if @grades.empty?

    @grades.first >= PASSING_GRADE
  end

  def graded?
    !@grades.empty?
  end

  private

  def not_valid_grade?(grade)
    !(grade.is_a? Numeric) || grade > MAX_GRADE || grade.negative?
  end
end
