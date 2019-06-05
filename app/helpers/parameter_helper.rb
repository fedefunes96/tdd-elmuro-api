class ParameterHelper
  def initialize(params)
    @params = params
  end

  def all_params?(body)
    (@params.values - body.keys).empty?
  end
end
