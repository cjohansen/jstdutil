require "jstdutil/test_runner"
require "jstdutil/hooks"
require "watchr"

module Jstdutil
  class Autotest
    attr_reader :runner
    AVAILABLE_HOOKS = [:initialize, :died, :quit, :ran_command, :run_command, :waiting]
    include Hooks

    def initialize(args)
      absolute_path = Pathname(File.join(Jstdutil.install_dir, "watchr_script"))
      script = Watchr::Script.new(absolute_path)
      @watchr_controller = Watchr::Controller.new(script, Watchr.handler.new)
      @runner = Jstdutil::TestRunner.new
      $jstestdriver_test_runner = @runner
      @interrupted_at = nil
    end

    def run
      hook(:initialize)

      trap("INT") do
        if @interrupted_at && Time.now - @interrupted_at < 2
          puts "No more testing today, shutting down"
          @runner.finalize
          exit
        else
          @interrupted_at = Time.now
          puts "Running all tests, hit Ctrl-c again to exit"
          @runner.run
        end
      end

      @runner.run
      @watchr_controller.run
    end
  end
end
