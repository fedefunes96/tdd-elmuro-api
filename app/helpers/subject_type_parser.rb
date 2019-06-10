class SubjectTypeParser
  TYPES = {
    parciales: :midterms,
    coloquio: :finals,
    tareas: :assignments
  }.freeze

  def parse(type)
    TYPES[type.to_sym]
  end
end
