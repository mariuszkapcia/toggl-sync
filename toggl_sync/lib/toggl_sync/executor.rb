module TogglSync
  class Executor
    def since(date)
      date_string     ||= Date.today.to_s
      number_of_days  = TogglSync::Utils.days_ago(date)

      sync(number_of_days)
    end

    def days_ago(number_of_days)
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
        begin
          log_with_carriage(time_entry, :syncing)
          worklog = Jira::Worklog.new(config: config, time_entry: time_entry)
          if can_sync?(time_entry) && worklog.valid?
            jira_adapter.push_worklog(worklog)
            time_entry.tag_as_synced
            toggl_adapter.push_time_entry_tags(time_entry)
            log_with_newline(time_entry, :synced)
          else
            reason = out_of_sync_reason(time_entry, worklog)
            log_with_newline(time_entry, reason)
          end
        rescue Toggl::AdapterError => exception
          log_with_newline(time_entry, "toggl failure, reason: #{exception.message}")
        rescue Jira::AdapterError => exception
          log_with_newline(time_entry, "jira failure, reason: #{exception.message}")
        rescue StandardError => exception
          log_with_newline(time_entry, "toggl-sync failure, reason: #{exception.message}")
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
      return :running           if time_entry.running?
      return :already_synced    if time_entry.synced?
      return :missing_issue_key if !worklog.valid?
    end

    def log_with_carriage(time_entry, status)
      message = "[#{time_entry.display_start_time}] "\
                "#{time_entry.display_description} "\
                '%-50.50s' % "#{status.to_s.humanize.downcase}"
      TogglSync::Logger.instance.log_with_carriage(message)
    end

    def log_with_newline(time_entry, status)
      message = "[#{time_entry.display_start_time}] "\
                "#{time_entry.display_description} "\
                '%-50.50s' % "#{status.to_s.humanize.downcase}"
      TogglSync::Logger.instance.log_with_newline(message)
    end
  end
end
