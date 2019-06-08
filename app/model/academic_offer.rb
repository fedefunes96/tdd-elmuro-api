class AcademicOffer
  def initialize(subjects)
    @subjects = subjects
  end

  def offer_for(_student)
    @subjects
  end
end
