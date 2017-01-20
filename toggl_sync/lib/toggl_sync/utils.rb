module TogglSync
  class Utils
    def self.days_ago(date)
      [0, (Date.today - date).to_i + 1].max
    end

    def self.date(date_string)
      Date.parse(date_string, 'dd-mm-yyyy')
    rescue StandardError
      raise TogglSync::DateParseError.new, ''
    end
  end
end
