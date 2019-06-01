require_relative '../model/subject'

class SubjectController
  NAME = 'nombre'.freeze
  CODE = 'codigo'.freeze
  def create(json_body)
    body = JSON.parse(json_body)
    subject = Subject.new(body[NAME], body[CODE])
    SubjectRepository.new.save(subject)
    { resultado: 'materia_creada' }.to_json
  end
end
