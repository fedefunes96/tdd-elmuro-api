require_relative 'inscription'
require_relative '../exceptions/invalid_inscription'

class Student
  attr_accessor :name, :username, :inscriptions

  def initialize(name, username)
    @name = name
    @username = username
    @inscriptions = []
  end

  def inscript(subject)
    raise InvalidInscription if inscripted_in(subject)

    @inscriptions << (Inscription.new self, subject)
  end

  def inscripted_in(subject)
    @inscriptions.any? { |inscription| inscription.subject.code == subject.code }
  end
end
