require 'json'
require_relative '../helpers/status_code'
require_relative '../../repositories/inscription_repository'

class GradesController
  SUBJECT_CODE = 'codigo_materia'.freeze
  USERNAME = 'username_alumno'.freeze
  GRADES = 'notas'.freeze

  SUCCESS_MESSAGE = 'notas_creadas'.freeze
  def initialize
    @inscription_repository = InscriptionRepository.new
  end

  def grade(body)
    inscription = @inscription_repository
                  .find_by_student_and_code(body[USERNAME], body[SUBJECT_CODE])

    return nil if inscription.nil?

    grades = parse_grades(body[GRADES])
    inscription.add_grades(grades)
    @inscription_repository.save(inscription)
    [{ resultado: SUCCESS_MESSAGE }, StatusCode::OK]
  end

  private

  def parse_grades(grades)
    [Integer(grades)]
  rescue ArgumentError
    JSON.parse(grades)
  end
end
