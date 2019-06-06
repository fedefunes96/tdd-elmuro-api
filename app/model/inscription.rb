require_relative '../../app/exceptions/invalid_grade_error'

class Inscription
  PASSING_GRADE = 4
  MAX_GRADE = 10

  attr_accessor :student, :subject, :grades

  def initialize(student, subject, grades = [])
    @student = student
    @subject = subject
    @grades = grades
  end

  def ==(other)
    @student.username == other.student.username &&
      @subject.code == other.subject.code
  end

  def add_grades(grades)
    grades.each { |x| raise InvalidGradeError if x > MAX_GRADE || x.negative? }
    @grades = grades
  end

  def passing?
    return false if @grades.empty?

    @grades.first >= PASSING_GRADE
  end

  def graded?
    !@grades.empty?
  end
end
