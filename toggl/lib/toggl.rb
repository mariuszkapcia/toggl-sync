module Toggl
  AdapterError = Class.new(StandardError)
end

require_relative 'toggl/adapter'
require_relative 'toggl/time_entry'
