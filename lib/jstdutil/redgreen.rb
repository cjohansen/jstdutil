if RUBY_PLATFORM =~ /mswin/i || RUBY_PLATFORM =~ /mingw/i || RUBY_PLATFORM =~ /bccwin/i || RUBY_PLATFORM =~ /wince/i
  begin
    require 'Win32/Console/ANSI'
  rescue LoadError
    raise 'You must gem install win32console to use color on Windows'
  end
end

module Jstdutil
  class RedGreen
    # Borrowed from the ruby redgreen gem
    # Not included as a gem dependency since it drags in Test::Unit
    # and friends, which is overkill for our situation
    module Color
      COLORS = { :clear => 0, :bright => 1, :red => 31, :green => 32, :yellow => 33 }

      def self.method_missing(color_name, *args)
        color(:bright) + color(color_name) + args.first + color(:clear)
      end

      def self.color(color)
        "\e[#{COLORS[color.to_sym]}m"
      end
    end

    def self.wrap_report(report)
      report
    end

  end
end
