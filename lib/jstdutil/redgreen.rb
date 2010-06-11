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

  end
end
