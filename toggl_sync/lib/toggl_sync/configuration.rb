require 'yaml'

module TogglSync
  class Configuration
    def verbose
      config['verbose']
    end

    def add_tag_to_worklogs
      config['add_tag_to_worklogs']
    end

    def toggl_api_token
      config['toggl']['api_token']
    end

    def jira_username
      config['jira']['username']
    end

    def jira_password
      config['jira']['password']
    end

    def jira_site
      config['jira']['site']
    end

    private

    attr_reader :config

    def initialize(path)
      @config = YAML::load(File.open(path))['toggl_sync']
    rescue StandardError
      raise TogglSync::ConfigurationLoadError.new, ''
    end
  end
end
