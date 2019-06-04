require_relative 'inscription'

class InscriptionSystem
  def create_inscription(student, subject)
    Inscription.new student, subject
  end
end
