require_relative 'base_grader'

class FinalsGrader < BaseGrader
  MAX_GRADES = 1

  def final_grade
    @grades.first
  end

  def passing?
    final_grade >= PASSING_GRADE
  end

  protected

  def grade_count_valid?(grade_count)
    grade_count == MAX_GRADES
  end
end
