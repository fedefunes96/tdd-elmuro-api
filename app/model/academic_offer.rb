class AcademicOffer
  def initialize(subjects, inscription_system)
    @subjects = subjects
    @inscription_system = inscription_system
  end

  def offer_for(_student)
    @subjects
  end
end
