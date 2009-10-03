require "jstdutil/redgreen"
require "autotest"

# module JsTestDriver
#   class JsAutoTest
#     attr_reader :interval, :classpath

#     def initialize(options = {})
#       @interval = options[:interval] || 2
#       @classpath = options[:classpath]
#     end

#     #
#     # Run all tests and return colorized report
#     #
#     def test_all
#       JsTestDriver.run("--tests all", classpath)
#     end

#     #
#     # Monitor filesystem for changes and run
#     #
#     def run
#       while forever
#         changeset = `find . -name *.js -cmin -#{interval/60.0}`.split("\n")
#         puts(test_all) if changeset.count > 0
#         sleep interval
#       end
#     end

#    private
#     def forever
#       true
#     end
#   end
# end

Autotest.add_hook :run_command do |at|
  # run js test driver
  results = 'JS Test Driver:'
  #results += `java -jar "#{@@jar}" --config "#{@@config_file}" --tests all --verbose`
  #puts results

  at.results = [] #if at.results.nil?
  #at.results.concat(results.split("\n"))

  at.hook :ran_js_test_driver
end
