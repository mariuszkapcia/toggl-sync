module TogglSync
  class Executor
    def since(date_string)
      date_string     ||= Date.today.to_s
      number_of_days  = TogglSync::Utils.days_ago(
        TogglSync::Utils.date(date_string)
      )

      TogglSync::Logger.instance.log("syncing #{number_of_days} days")
      sync(number_of_days)
    end

    private

    attr_reader :config, :toggl_adapter, :jira_adapter

    def initialize(config:)
      @config         = config
      @toggl_adapter  = Toggl::Adapter.new(config: config)
      @jira_adapter   = Jira::Adapter.new(config: config)
    end

    def sync(number_of_days)
      time_entries = fetch_time_entries(number_of_days)
      time_entries.each do |time_entry|
        TogglSync::Logger.instance.log("syncing time entry '#{time_entry.description}'")
        worklog = Jira::Worklog.new(config: config, time_entry: time_entry)
        if can_sync?(time_entry) && worklog.valid?
          jira_adapter.push_worklog(worklog)
          time_entry.tag_as_synced
          toggl_adapter.push_time_entry_tags(time_entry)
          TogglSync::Logger.instance.log('time entry synced')
        else
          reason = out_of_sync_reason(time_entry, worklog)
          TogglSync::Logger.instance.log("time entry can't be synced, reason: '#{reason}'")
        end
      end
    end

    def fetch_time_entries(number_of_days)
      toggl_adapter.get_time_entries(number_of_days)
    end

    def can_sync?(time_entry)
      !time_entry.running? && !time_entry.synced?
    end

    def out_of_sync_reason(time_entry, worklog)
      return 'still running'      if time_entry.running?
      return 'already synced'     if time_entry.synced?
      return 'missing issue key'  if !worklog.valid?
      'unknown'
    end
  end
end
