require_relative 'base_grader'

class AssignmentsGrader < BaseGrader
  FAIL_GRADE = 6

  def passing?
    mean >= FAIL_GRADE
  end

  private

  def mean
    @grades.reduce(&:+) / @grades.size.to_f
  end

  def grade_count_valid?(grade_count)
    grade_count.positive?
  end
end
