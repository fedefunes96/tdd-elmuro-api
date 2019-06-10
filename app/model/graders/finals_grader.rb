class FinalsGrader
  MAX_GRADES = 1

  def validate!(grades)
    raise InvalidGradeError if grades.size > MAX_GRADES
  end
end
