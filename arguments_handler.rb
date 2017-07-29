class ArgumentsHandler
  def since_date
    date_string = arguments[0].to_s
    date_string = Date.today.to_s if arguments[0].nil?
    TogglSync::Utils.date(date_string)
  end

  private

  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end
end
