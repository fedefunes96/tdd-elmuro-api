require_relative 'base_grader'

class AssignmentsGrader < BaseGrader
  FAIL_GRADE = 4

  def passing?
    @grades.first > FAIL_GRADE
  end
end
