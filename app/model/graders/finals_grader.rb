require_relative 'base_grader'

class FinalsGrader < BaseGrader
  def final_grade
    @grades.first
  end

  def passing?
    final_grade >= PASSING_GRADE
  end
end
