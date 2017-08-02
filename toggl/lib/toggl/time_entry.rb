module Toggl
  class TimeEntry
    attr_reader :id, :duration, :tags, :running, :description, :start_time

    def running?
      running
    end

    def synced?
      tags.include?(jira_sync_tag)
    end

    def tag_as_synced
      tags.push(jira_sync_tag)
    end

    def display_start_time
      DateTime.parse(start_time).utc.strftime("%Y-%m-%d %H:%M:%S")
    end

    def display_description
      return '%-100.100s' % '' if description.nil?
      '%-100.100s' % description.gsub(/^(.{95,}?).*$/m,'\1...')
    end

    def to_s
      {
        id:           id,
        duration:     duration,
        tags:         tags,
        running:      running,
        description:  description,
        start_time:   start_time
      }.to_s
    end

    private

    def initialize(data)
      @id           = data['id']
      @duration     = data['duration']
      @tags         = data['tags'].to_a
      @running      = data['duration'] < 0
      @description  = data['description']
      @start_time   = data['start']
    end

    def jira_sync_tag
      'synced-with-jira'
    end
  end
end
