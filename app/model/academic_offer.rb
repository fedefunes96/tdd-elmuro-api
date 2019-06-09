class AcademicOffer
  def initialize(subjects, inscription_system)
    @subjects = subjects
    @inscription_system = inscription_system
  end

  def offer_for(student)
    @subjects.reject { |subject| @inscription_system.passed_subject?(student, subject) }
  end

  def all_subjects
    @subjects.clone
  end
end
