require 'cgi'

module JIRA
  module Resource

    class AgileFactory < JIRA::BaseFactory # :nodoc:
    end

    class Agile < JIRA::Base

      def self.all(client)
        response = client.get(path_base(client) + '/board')
        parse_json(response.body)
      end

      def self.get_backlog_issues(client, board_id, options = {})
        options[:maxResults] ||= 100
        response = client.get("/rest/agile/1.0/board/#{board_id}/backlog?maxResults=#{options[:maxResults]}")
        parse_json(response.body)
      end

      def self.get_sprints(client, board_id, options = {})
        options[:maxResults] ||= 100
        response = client.get("/rest/agile/1.0/board/#{board_id}/sprint?maxResults=#{options[:maxResults]}")
        parse_json(response.body)
      end

      def self.get_sprint_issues(client, sprint_id, options = {})
        options[:maxResults] ||= 100
        response = client.get("/rest/agile/1.0/sprint/#{sprint_id}/issue?maxResults=#{options[:maxResults]}")
        parse_json(response.body)
      end

      # def self.find(client, key, options = {})
      #   options[:maxResults] ||= 100
      #   fields = options[:fields].join(',') unless options[:fields].nil?
      #   response = client.get("/rest/api/latest/search?jql=sprint=#{key}&fields=#{fields}&maxResults=#{options[:maxResults]}")
      #   parse_json(response.body)
      # end

      private

      def self.path_base(client)
        client.options[:context_path] + '/rest/agile/1.0'
      end

      def path_base(client)
        self.class.path_base(client)
      end

    end

  end
end
