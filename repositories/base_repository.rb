require_relative '../app/app'

class BaseRepository
  def save(a_record)
    if !find_dataset(a_record).empty?
      update(a_record)
    else
      insert(a_record)
    end
  end

  def destroy(a_record)
    find_dataset(a_record).delete.positive?
  end
  alias delete destroy

  def delete_all
    dataset.delete
  end

  def all
    dataset
  end

  class << self
    attr_accessor :table_name
  end

  protected

  def dataset
    # rubocop:disable Style/GlobalVars
    $DB[self.class.table_name]
    # rubocop:enable Style/GlobalVars
  end

  def find_dataset(_row)
    raise SubclassResponsability
  end

  def update(a_record)
    find_dataset(a_record).update(changeset(a_record))
  end

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def changeset(_a_record)
    raise SubclassResponsability
  end
end
