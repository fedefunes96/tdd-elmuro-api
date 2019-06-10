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
      inscription_of?(inscription, student, subject)
    end
  end

  def enough_slots?(subject)
    occupied_slots(subject) < subject.max_students
  end

  def remaining_slots(subject)
    subject.max_students - occupied_slots(subject)
  end

  def passed_subject?(student, subject)
    @inscriptions.select { |x| x.student == student && x.subject == subject && x.passing? }.any?
  end

  def add_grades(student, subject, grades)
    inscription = @inscriptions.select do |ins|
      inscription_of?(ins, student, subject)
    end.first

    inscription.add_grades(grades)
  end

  def graded?(student, subject)
    @inscriptions.any? do |inscription|
      inscription_of?(inscription, student, subject) && inscription.graded?
    end
  end

  def passing?(student, subject)
    @inscriptions.any? do |inscription|
      inscription_of?(inscription, student, subject) && inscription.passing?
    end
  end

  protected

  attr_accessor :inscriptions

  private

  def inscription_of?(inscription, student, subject)
    inscription.subject == subject &&
      inscription.student == student
  end

  def occupied_slots(subject)
    @inscriptions.count do |inscription|
      inscription.subject == subject
    end
  end
end
