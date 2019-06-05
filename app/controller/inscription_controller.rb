class InscriptionController
  NAME = 'nombre_completo'.freeze
  USERNAME = 'username_alumno'.freeze
  CODE = 'codigo_materia'.freeze

  SUCCESS_MESSAGE = 'inscripcion_creada'.freeze
  PARAMETER_MISSING = 'parametro_faltante'.freeze

  def create(body)
    return api_response(PARAMETER_MISSING), 400 unless all_params?(body)

    [api_response(SUCCESS_MESSAGE), 201]
  end

  private

  def all_params?(body)
    body.include?(NAME) && body.include?(CODE) && body.include?(USERNAME)
  end

  def api_response(message)
    { error: message, resultado: message }
  end
end
