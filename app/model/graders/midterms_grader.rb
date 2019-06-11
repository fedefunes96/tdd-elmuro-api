require_relative 'base_grader'

class MidtermsGrader < BaseGrader
  AMOUNT_OF_GRADES = 2
  PASSING_GRADE = 6

  def final_grade
    @grades.reduce(&:+) / @grades.size.to_f
  end

  def passing?
    final_grade >= PASSING_GRADE
  end

  private

  def grade_count_valid?(count)
    count == AMOUNT_OF_GRADES
  end
end
