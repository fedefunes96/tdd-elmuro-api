class Inscription
  attr_accessor :student, :subject, :grades

  def initialize(student, subject, grades = nil)
    @student = student
    @subject = subject
    @grades = grades || []
  end

  def ==(other)
    @student.username == other.student.username &&
      @subject.code == other.subject.code
  end
end
