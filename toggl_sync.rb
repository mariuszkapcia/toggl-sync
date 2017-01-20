# NOTE Loading TogglV8 and dependencies
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/togglv8-1.2.1/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/faraday-0.11.0/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/multipart-post-2.0.0/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/oj-2.18.1/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/logger-1.2.8/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/awesome_print-1.7.0/lib")

# NOTE Loading JiraRuby and dependencies
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/jira-ruby-1.2.0/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/activesupport-5.0.1/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/concurrent-ruby-1.0.4/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/i18n-0.7.0/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/tzinfo-1.2.2/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/thread_safe-0.3.5/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/vendor/bundle/gems/oauth-0.5.1/lib")

# NOTE Loading own libs
$LOAD_PATH.unshift("#{Dir.pwd}/toggl/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/jira/lib")
$LOAD_PATH.unshift("#{Dir.pwd}/toggl_sync/lib")

require_relative 'arguments_handler'

require 'toggl'
require 'jira'
require 'toggl_sync'

begin
  toggl_config      = TogglSync::Configuration.new('./config.yml')
  TogglSync::Logger.instance.verbose(toggl_config.verbose)
  TogglSync::Logger.instance.log('starting new session')
  arguments_handler = ArgumentsHandler.new(ARGV)
  toggl_sync        = TogglSync::Executor.new(config: toggl_config)

  toggl_sync.since(arguments_handler.since_date)
  TogglSync::Logger.instance.log("ending session \n")
rescue TogglSync::ConfigurationLoadError
  TogglSync::Logger.instance.error("Loading TogglSync configuration failure \n")
rescue TogglSync::DateParseError
  TogglSync::Logger.instance.error("Parsing date failure \n")
rescue Toggl::AdapterError
  TogglSync::Logger.instance.error("Toggl servers communication failure \n")
rescue Jira::AdapterError
  TogglSync::Logger.instance.error("Jira servers communication failure \n")
rescue StandardError => exception
  TogglSync::Logger.instance.error("Unknown eror with message '#{exception}' \n")
end
