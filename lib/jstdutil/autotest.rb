require "jstdutil/test_runner"
require "watchr"

module Jstdutil
  class Autotest
    def initialize(args)
      absolute_path = Pathname(File.join(Jstdutil.install_dir, "watchr_script"))
      script = Watchr::Script.new(absolute_path)
      @watchr_controller = Watchr::Controller.new(script, Watchr.handler.new)
      @runner = Jstdutil::TestRunner.new
      $jstestdriver_test_runner = @runner
    end

    def run
      @runner.run

      begin
        @watchr_controller.run
      rescue Exception
        @runner.finalize
        puts "Stopping"
      end
    end
  end
end
