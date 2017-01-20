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

    def log(msg)
      @logger.info(msg)
      puts "[INFO] #{msg}" if @verbose
    end

    def error(msg)
      @logger.error(msg)
      puts "[ERROR] #{msg}" if @verbose
    end

    private_class_method :new
  end
end
