module Jstdutil
  class ColorfulHtml

    module Color

      def self.method_missing(color_name, *args)
        color(color_name) + args.first + "</span>"
      end

      def self.color(color)
        "<span style='color: #{color};'>"
      end
    end
  
  end
end