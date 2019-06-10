class FinalsGrader
  MAX_GRADES = 1
  MAX_GRADE_VALUE = 10

  def validate!(grades)
    raise InvalidGradeError if grades.size > MAX_GRADES

    grades.each { |x| raise InvalidGradeError unless valid_grade?(x) }
  end

  def final_grade(grades)
    validate!(grades)
    grades.first
  end

  private

  def valid_grade?(grade)
    grade.is_a?(Numeric) && grade.positive? && grade <= MAX_GRADE_VALUE
  end
end
