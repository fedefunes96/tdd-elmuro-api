require_relative 'base_repository'

class StudentRepository < BaseRepository
  self.table_name = :students

  def find_by_username(username)
    row = dataset.first(username: username)
    load_student(row) unless row.nil?
  end

  protected

  def find_dataset(student)
    dataset.where(username: student.username)
  end

  def load_student(row)
    Student.new row[:name], row[:username]
  end

  def changeset(student)
    {
      name: student.name,
      username: student.username
    }
  end
end
