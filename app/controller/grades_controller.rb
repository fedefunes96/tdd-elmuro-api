require 'json'
require_relative '../../repositories/inscription_repository'

class GradesController
  SUBJECT_CODE = 'codigo_materia'.freeze
  USERNAME = 'username_alumno'.freeze
  GRADES = 'notas'.freeze
  def initialize
    @inscription_repository = InscriptionRepository.new
  end

  def grade(body)
    inscription = @inscription_repository
                  .find_by_student_and_code(body[USERNAME], body[SUBJECT_CODE])

    return nil if inscription.nil?

    inscription.add_grades(JSON.parse(body[GRADES]))
    @inscription_repository.save(inscription)
  end
end
