require_relative 'inscription'
require_relative '../exceptions/duplicate_inscription_error'
require_relative '../exceptions/no_available_quota_error'

class InscriptionSystem
  def initialize(inscriptions = [])
    @inscriptions = inscriptions
  end

  def create_inscription(student, subject)
    raise DuplicateInscriptionError if inscripted_to?(student, subject)
    raise NoAvailableQuotaError unless enough_slots?(subject)

    inscription = Inscription.new(student, subject)

    @inscriptions << inscription
    inscription
  end

  def inscripted_to?(student, subject)
    @inscriptions.any? do |inscription|
      inscription.subject.code == subject.code &&
        inscription.student.username == student.username
    end
  end

  def enough_slots?(subject)
    occupied_slots(subject) < subject.max_students
  end

  def remaining_slots(subject)
    subject.max_students - occupied_slots(subject)
  end

  protected

  attr_accessor :inscriptions

  private

  def occupied_slots(subject)
    @inscriptions.count do |inscription|
      inscription.subject.code == subject.code
    end
  end
end
