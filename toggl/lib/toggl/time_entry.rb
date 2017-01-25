module Toggl
  class TimeEntry
    attr_reader :id, :duration, :tags, :running, :description, :started

    def running?
      running
    end

    def synced?
      tags.include?(jira_sync_tag)
    end

    def tag_as_synced
      tags.push(jira_sync_tag)
    end

    def to_s
      {
        id:           id,
        duration:     duration,
        tags:         tags,
        running:      running,
        description:  description,
        started:      started
      }.to_s
    end

    private

    def initialize(data)
      @id           = data['id']
      @duration     = data['duration']
      @tags         = data['tags'].to_a
      @running      = data['duration'] < 0
      @description  = data['description']
      @started      = parse_start_datetime(data['start'])
    end

    def jira_sync_tag
      'synced-with-jira'
    end

    def parse_start_datetime(datetime)
      DateTime.parse(datetime).utc.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
    end
  end
end
