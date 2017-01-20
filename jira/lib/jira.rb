module Jira
  AdapterError = Class.new(StandardError)
end

require_relative 'jira/worklog'
require_relative 'jira/adapter'
