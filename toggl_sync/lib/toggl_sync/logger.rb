module TogglSync
  class Logger
    def initialize
      @verbose  = true
      @logger   = ::Logger.new('toggl_sync_logs.log')
    end

    @@instance = Logger.new

    def self.instance
      @@instance
    end

    def verbose(flag)
      @verbose = flag
    end

    def log_with_carriage(msg)
      @logger << "#{msg}\r"
      print("#{msg}\r") if @verbose
    end

    def log_with_newline(msg)
      @logger << "#{msg}\n"
      print("#{msg}\n") if @verbose
    end

    def error(msg)
      @logger << "[ERROR] #{msg}\n"
      print("[ERROR] #{msg}\n") if @verbose
    end

    private_class_method :new
  end
end
