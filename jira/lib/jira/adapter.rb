require 'jira-ruby'

module Jira
  class Adapter
    def push_worklog(worklog)
      issue       = fetch_issue(worklog.issue_key)
      new_worklog = issue.worklogs.build
      new_worklog.save!({
        comment:          worklog.message,
        timeSpentSeconds: worklog.duration,
        started:          worklog.started
      })
    rescue StandardError
      raise Jira::AdapterError.new, ''
    end

    private

    attr_reader :config, :api_handler

    def initialize(config:)
      @config       = config
      @api_handler  = JIRA::Client.new(
        username:     config.jira_username,
        password:     config.jira_password,
        site:         config.jira_site,
        context_path: '',
        auth_type:    :basic
      )
    end

    def fetch_issue(key)
      api_handler.Issue.find(key.to_s)
    end
  end
end
