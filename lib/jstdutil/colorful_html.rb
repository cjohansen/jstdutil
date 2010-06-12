module Jstdutil
  class ColorfulHtml

    module Color

      def self.method_missing(color_name, *args)
        color(color_name) + args.first + "</span>"
      end

      def self.color(color)
        "<span class='#{color}'>"
      end
    end
    
    def self.wrap_report(report)
      "<style>.red {color: #c00;} .green {color: #0c0;} .yellow {color: #ff0;} </style><pre>#{report}</pre>"
    end
  
  end
end