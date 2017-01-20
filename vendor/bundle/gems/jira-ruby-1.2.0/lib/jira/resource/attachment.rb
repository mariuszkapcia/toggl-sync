module JIRA
  module Resource

    class AttachmentFactory < JIRA::BaseFactory # :nodoc:
    end

    class Attachment < JIRA::Base
      has_one :author, :class => JIRA::Resource::User
    end

  end
end
