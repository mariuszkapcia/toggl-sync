class ArgumentsHandler
  def method
    arguments[0].to_s
  end

  def since_date
    date_string = arguments[1].to_s
    date_string = Date.today.to_s if arguments[1].nil?
    TogglSync::Utils.date(date_string)
  end

  def days_ago
    arguments[1].to_i + 1
  end

  private

  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end
end
