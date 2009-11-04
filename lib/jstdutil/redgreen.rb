begin
  require 'Win32/Console/ANSI' if PLATFORM =~ /win32/
rescue LoadError
  raise 'You must gem install win32console to use color on Windows'
rescue NameError
  # PLATFORM is not defined, not a problem on windows.
  # On other platforms we don't care
end
module Jstdutil
  class RedGreen
    # Borrowed from the ruby redgreen gem
    # Not included as a gem dependency since it drags in Test::Unit
    # and friends, which is overkill for our situation
    module Color
      COLORS = { :clear => 0, :red => 31, :green => 32, :yellow => 33 }

      def self.method_missing(color_name, *args)
        color(color_name) + args.first + color(:clear)
      end

      def self.color(color)
        "\e[#{COLORS[color.to_sym]}m"
      end
    end

    #
    # Process report from JsTestDriver and colorize it with beautiful
    # colors. Returns report with encoded colors.
    #
    def self.format(report)
      report.split("\n").collect do |line|
        if line =~ /Passed: \d+; Fails: (\d+); Errors:? (\d+)/
          Color.send($1.to_i + $2.to_i != 0 ? :red : :green, line)
        elsif line =~ /^[\.EF]+$/
          line.gsub(/\./, Color.green(".")).gsub(/F/, Color.red("F")).gsub("E", Color.yellow("E"))
        elsif line =~ /failed/
          Color.red(line)
        elsif line =~ /passed/
          Color.green(line)
        elsif line =~ /error/
          Color.yellow(line)
        else
          line
        end
      end.join("\n")
    end
  end
end
