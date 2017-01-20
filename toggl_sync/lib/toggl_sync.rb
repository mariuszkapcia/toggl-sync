module TogglSync
  ConfigurationLoadError  = Class.new(StandardError)
  DateParseError          = Class.new(StandardError)
end

require_relative 'toggl_sync/logger'
require_relative 'toggl_sync/utils'
require_relative 'toggl_sync/configuration'
require_relative 'toggl_sync/executor'
