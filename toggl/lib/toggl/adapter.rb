require 'togglv8'

module Toggl
  class Adapter
    def get_time_entries(number_of_days)
      response = api_handler.get_time_entries(
        start_date: (Date.today + 1 - number_of_days).to_s,
        end_date: (Date.today + 1).to_s
      )
      parse_time_entries(response)
    rescue StandardError
      raise Toggl::AdapterError.new, ''
    end

    def get_time_entry(time_entry)
      response = api_handler.get_time_entry(
        time_entry.id
      )
      Toggl::TimeEntry.new(response)
    rescue StandardError
      raise Toggl::AdapterError.new, ''
    end

    def push_time_entry_tags(time_entry)
      api_handler.update_time_entry(
        time_entry.id,
        tags: time_entry.tags, tag_action: 'add'
      )
    rescue StandardError
      raise Toggl::AdapterError.new, ''
    end

    private

    attr_reader :config, :api_handler

    def initialize(config:)
      @config       = config
      @api_handler  = TogglV8::API.new(config.toggl_api_token)
    end

    def parse_time_entries(time_entries_data)
      time_entries_data.map do |time_entry_data|
        Toggl::TimeEntry.new(time_entry_data)
      end
    end
  end
end
