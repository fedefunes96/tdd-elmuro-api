require_relative 'inscription'

class Student
  attr_accessor :name, :username, :inscriptions

  def initialize(name, username)
    @name = name
    @username = username
    @inscriptions = []
  end

  def ==(other)
    @username == other.username
  end
end
