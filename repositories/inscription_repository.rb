require_relative 'base_repository'
require_relative 'student_repository'
require_relative 'subject_repository'

class InscriptionRepository < BaseRepository
  self.table_name = :inscriptions

  def all_inscriptions
    find_inscriptions
  end

  def find_by_student_and_code(username, code)
    find_inscriptions(dataset.where(username: username,
                                    subject_code: code)).first
  end

  protected

  def find_dataset(inscription)
    dataset.where(username: inscription.student.username,
                  subject_code: inscription.subject.code)
  end

  def changeset(inscription)
    {
      username: inscription.student.username,
      subject_code: inscription.subject.code,
      grades: inscription.grades.to_s
    }
  end

  private

  def find_inscriptions(data = nil)
    data = dataset if data.nil?
    inscriptions = []

    StudentRepository.new.all.join(data, username: :username)
                     .join(SubjectRepository.new.all, code: :subject_code)
                     .each do |row|
      student = retrieve_student(row)
      subject = retrieve_subject(row)
      grades = retrieve_grades(row)
      inscriptions << (Inscription.new student, subject, grades)
    end

    inscriptions
  end

  def retrieve_grades(row)
    if row[:grades].nil?
      []
    else
      JSON.parse(row[:grades])
    end
  end

  def retrieve_student(row)
    Student.new(row[:name], row[:username])
  end

  def retrieve_subject(row)
    Subject.new(row[:name],
                row[:code],
                row[:teacher],
                row[:max_students],
                row[:projector],
                row[:laboratory])
  end
end
