class Inscription
  PASSING_GRADE = 4
  attr_accessor :student, :subject, :grades

  def initialize(student, subject, grades = nil)
    @student = student
    @subject = subject
    @grades = if grades.nil?
                []
              else
                grades
              end
  end

  def ==(other)
    @student.username == other.student.username &&
      @subject.code == other.subject.code
  end

  def add_grades(grades)
    @grades = grades
  end

  def passing?
    return false if @grades.empty?

    @grades.first >= PASSING_GRADE
  end
end
