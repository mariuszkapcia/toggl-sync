class ArgumentsHandler
  def since_date
    arguments[0].nil? ? nil : arguments[0].to_s
  end

  private

  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end
end
