class Inscription
  attr_accessor :student, :subject

  def initialize(student, subject)
    @student = student
    @subject = subject
  end

  def ==(other)
    @student.username == other.student.username &&
      @subject.code == other.subject.code
  end
end
