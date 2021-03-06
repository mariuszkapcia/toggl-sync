module Jira
  class Worklog
    attr_reader :issue_key, :duration, :message, :start_time

    def valid?
      !issue_key.nil?
    end

    def to_s
      {
        issue_key:  issue_key,
        duration:   duration,
        message:    message,
        start_time: start_time
      }.to_s
    end

    private

    attr_reader :config

    def initialize(config:, time_entry:)
      @config     = config
      @issue_key  = find_issue_key(time_entry.description)
      @duration   = time_entry.duration
      @message    = parse_message(@issue_key, time_entry.description)
      @start_time = parse_start_datetime(time_entry.start_time)
    end

    def find_issue_key(text)
      match_result = text.to_s.match(issue_key_regex)
      match_result ? match_result.captures.first.upcase : nil
    end

    def parse_message(issue_key, text)
      "#{text.to_s.sub(issue_key_regex, '').strip} #{logged_tag}".strip
    end

    def logged_tag
      return '[created by TogglSync]' if config.add_tag_to_worklogs
      ''
    end

    def issue_key_regex
      /(?:\s|^)([A-Za-z]+-[0-9]+)(?=\s|$)/i
    end

    def parse_start_datetime(datetime)
      DateTime.parse(datetime).utc.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
    end
  end
end
