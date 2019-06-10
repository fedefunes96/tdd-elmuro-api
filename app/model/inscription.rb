require_relative '../../app/exceptions/invalid_grade_error'

class Inscription
  attr_accessor :student, :subject, :grades

  def initialize(student, subject)
    @student = student
    @subject = subject
    @grades = []
    @grader = nil
  end

  def ==(other)
    @student == other.student &&
      @subject == other.subject
  end

  def add_grades(grades)
    @grader = @subject.get_grader(grades)
    @grades = grades
  end

  def passing?
    return false if @grades.empty?

    @grader.passing?
  end

  def graded?
    !@grades.empty?
  end
end
