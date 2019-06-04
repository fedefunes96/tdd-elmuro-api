require_relative 'inscription'
require_relative '../exceptions/invalid_inscription'

class InscriptionSystem
  def initialize
    @inscriptions = []
  end

  def create_inscription(student, subject)
    inscription = (Inscription.new student, subject)
    @inscriptions << inscription
    inscription
  end

  def inscripted_to?(student, subject)
    @inscriptions.any? do |inscription|
      inscription.subject.code == subject.code &&
        inscription.student.username == student.username
    end
  end
end
