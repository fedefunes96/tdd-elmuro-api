require_relative '../model/subject'

class SubjectController
  NAME = 'nombre'.freeze
  CODE = 'codigo'.freeze
  MAX_STUDENTS = 'cupo'.freeze

  def create(json_body)
    body = JSON.parse(json_body)
    return { resultado: 'parametro_faltante' } unless all_params?(body)

    subject = Subject.new(body[NAME], body[CODE], body[MAX_STUDENTS])
    SubjectRepository.new.save(subject)
    { resultado: 'materia_creada' }.to_json
  end

  private

  def all_params?(body)
    body.include?(NAME) && body.include?(CODE) && body.include?(MAX_STUDENTS)
  end
end
