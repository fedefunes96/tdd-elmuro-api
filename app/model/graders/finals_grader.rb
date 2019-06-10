class FinalsGrader
  MAX_GRADES = 1
  MAX_GRADE_VALUE = 10

  PASSING_GRADE = 4

  def initialize(grades)
    validate!(grades)
    @grades = grades
  end

  def final_grade
    @grades.first
  end

  def passing?
    final_grade >= PASSING_GRADE
  end

  private

  def valid_grade?(grade)
    grade.is_a?(Numeric) && grade.positive? && grade <= MAX_GRADE_VALUE
  end

  def validate!(grades)
    raise InvalidGradeError if grades.size > MAX_GRADES

    grades.each { |x| raise InvalidGradeError unless valid_grade?(x) }
  end
end
