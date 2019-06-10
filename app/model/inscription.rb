require_relative '../../app/exceptions/invalid_grade_error'
require_relative '../../app/exceptions/no_grades_error'

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
    @grades = grades
    @grader = @subject.get_grader(grades) unless @grades.empty?
  end

  def passing?
    return false unless graded?

    @grader.passing?
  end

  def graded?
    !@grades.empty?
  end

  def final_grade
    raise NoGradesError if @grader.nil?

    @grader.final_grade
  end
end
