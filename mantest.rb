$LOAD_PATH.unshift("/home/christian/projects/jstdutil/lib/")
require "jstdutil"
require "jstdutil/test_runner"

runner = Jstdutil::TestRunner.new
runner.run

at_exit do
  "Exiting"
end
