require_relative 'base_grader'

class AssignmentsGrader < BaseGrader
  FINAL_PASS_GRADE = 6
  MAX_FAILED_PERMITTED = 2
  SINGLE_ASSIGNMENT_FAIL_GRADE = 4

  def passing?
    mean >= FINAL_PASS_GRADE && failed_count <= MAX_FAILED_PERMITTED
  end

  def final_grade
    mean
  end

  private

  def mean
    @grades.reduce(&:+) / @grades.size.to_f
  end

  def grade_count_valid?(grade_count)
    grade_count.positive?
  end

  def failed_count
    @grades.select { |x| x < SINGLE_ASSIGNMENT_FAIL_GRADE }.size
  end
end
