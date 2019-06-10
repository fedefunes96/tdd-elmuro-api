class FinalsGrader
  MAX_GRADES = 1

  def validate!(grades)
    raise InvalidGradeError if grades.size > MAX_GRADES

    grades.each { |x| raise InvalidGradeError unless valid_grade?(x) }
  end

  private

  def valid_grade?(grade)
    grade.is_a? Numeric
  end
end
