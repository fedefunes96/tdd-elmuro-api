class Student
  attr_accessor :name, :username, :inscriptions

  def initialize(name, username)
    @name = name
    @username = username
    @inscriptions = []
  end

  def inscript(subject)
    @inscriptions << subject.code
  end
end
