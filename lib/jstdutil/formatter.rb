module Jstdutil
  class Formatter
    #
    # Process report from JsTestDriver and colorize it with beautiful
    # colors. Returns report with encoded colors.
    #
    def self.format(report, type)
      return "" if report.nil?

      begin
        type.wrap_report(report.split("\n").collect do |line|
          if line =~ /Passed: 0; Fails: 0; Errors:? 0/
            type::Color.yellow(line)
          elsif line =~ /Passed: \d+; Fails: (\d+); Errors:? (\d+)/
            type::Color.send($1.to_i + $2.to_i != 0 ? :red : :green, line)
          elsif line =~ /^[\.EF]+$/
            line.gsub(/\./, type::Color.green(".")).gsub(/F/, type::Color.red("F")).gsub("E", type::Color.yellow("E"))
          elsif line =~ /failed\s\(\d|\[ERROR\]/
            type::Color.red(line)
          elsif line =~ /passed\s\(\d/
            type::Color.green(line)
          elsif line =~ /error|\[WARN\]/
            type::Color.yellow(line)
          else
            line
          end
        end.join("\n"))
      rescue
        report
      end
    end
  end
end
