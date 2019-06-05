require_relative 'base_repository'
require_relative 'student_repository'
require_relative 'subject_repository'

class InscriptionRepository < BaseRepository
  self.table_name = :inscriptions

  def all_inscriptions
    inscriptions = []

    dataset.each do |row|
      student = StudentRepository.new.find_by_username(row[:username])
      subject = SubjectRepository.new.find_by_code(row[:subject_code])
      inscriptions << (Inscription.new student, subject)
    end

    inscriptions
  end

  protected

  def find_dataset(inscription)
    dataset.where(username: inscription.student.username,
                  subject_code: inscription.subject.code)
  end

  def changeset(inscription)
    {
      username: inscription.student.username,
      subject_code: inscription.subject.code
    }
  end
end
