require_relative 'base_repository'

class SubjectRepository < BaseRepository
  self.table_name = :subjects

  def find_by_code(code)
    row = dataset.first(code: code)
    load_subject(row) unless row.nil?
  end

  def all_subjects
    all.map(&method(:load_subject))
  end

  protected

  def find_dataset(subject)
    dataset.where(code: subject.code)
  end

  def load_subject(row)
    Subject.new(row[:name], row[:code], row[:teacher],
                row[:max_students], row[:projector], row[:laboratory], row[:type].to_sym)
  end

  def changeset(subject)
    {
      name: subject.name,
      code: subject.code,
      teacher: subject.teacher,
      max_students: subject.max_students,
      projector: subject.projector,
      laboratory: subject.laboratory,
      type: subject.type.to_s
    }
  end
end
