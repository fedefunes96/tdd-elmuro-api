require_relative '../exceptions/student_limit_error'
require_relative '../exceptions/invalid_subject_settings_error'
require_relative '../exceptions/invalid_max_students_error'
require_relative '../exceptions/invalid_subject_name_error'
require_relative '../model/graders/finals_grader'
require_relative '../model/graders/assignments_grader'
require_relative '../model/graders/midterms_grader'

class Subject
  MAX_STUDENTS_LIMIT = 300
  MIN_STUDENTS_LIMIT = 0
  MIN_CODE_LENGTH = 1
  MAX_CODE_LENGTH = 4
  MIN_NAME_LENGTH = 1
  MAX_NAME_LENGTH = 50

  SUBJECT_TYPES = %i[
    midterms
    assignments
    finals
  ].freeze

  GRADERS = {
    finals: FinalsGrader,
    assignments: AssignmentsGrader,
    midterms: MidtermsGrader
  }.freeze

  attr_accessor :name, :code, :max_students, :teacher, :projector, :laboratory, :type

  def initialize(name, code, teacher, max_students, projector, laboratory, type)
    validate_params!(code, laboratory, max_students, projector, name, type)
    @name = name
    @code = code
    @teacher = teacher
    @max_students = max_students
    @projector = projector
    @laboratory = laboratory
    @type = type
  end

  def ==(other)
    @code == other.code
  end

  def get_grader(grades)
    raise InvalidSubjectTypeError if GRADERS[@type].nil?

    GRADERS[@type].new(grades)
  end

  private

  def validate_params!(code, laboratory, max_students, projector, name, type)
    validate_settings(projector, laboratory)
    validate_max_students(max_students)
    validate_code(code)
    validate_name(name)
    validate_type(type)
  end

  def validate_code(code)
    raise InvalidSubjectCodeError unless valid_code?(code)
  end

  def valid_code?(code)
    code.length.between?(MIN_CODE_LENGTH, MAX_CODE_LENGTH)
  end

  def validate_max_students(max_students)
    raise InvalidMaxStudentsError if max_students <= MIN_STUDENTS_LIMIT

    raise StudentLimitError if max_students > MAX_STUDENTS_LIMIT
  end

  def validate_settings(projector, laboratory)
    msg = 'Subject can not have projector and laboratory at the same time'
    raise(InvalidSubjectSettingsError, msg) if projector && laboratory
  end

  def validate_name(name)
    raise(InvalidSubjectNameError) unless valid_name?(name)
  end

  def valid_name?(name)
    name.length.between?(MIN_NAME_LENGTH, MAX_NAME_LENGTH)
  end

  def validate_type(type)
    raise(InvalidSubjectTypeError) unless SUBJECT_TYPES.include?(type)
  end
end
