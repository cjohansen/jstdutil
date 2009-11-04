module Jstdutil
  module JsTestDriver
    # Simple interface to JsTestDriver configuration
    # Can instantiate with either a configuration file or string contents
    #
    #   config = Jstdutil::JsTestDriverConfig.new "jsTestDriver.conf"
    #   config.server #=> "http://localhost:4224"
    #
    class Config
      def initialize(file)
        begin
          load_config(File.read(file))
        rescue
          load_config(file)
        rescue
          msg = "Configuration must be an existing file or valid JsTestDriver " <<
                "configuration string (contain atleast server)"
          raise ArgumentError.new(msg)
        end
      end

      def method_missing(name, *args, &block)
        return @contents[name.to_s] if @contents.key?(name.to_s)
        super
      end

      def respond_to?(name)
        return true if @contents.key?(name.to_s)
        super
      end

     private
      def load_config(contents)
        @contents = YAML.load(contents)

        if !@contents.respond_to?(:key?) || !@contents.key?("server")
          raise ArgumentError.new("Error: Unable to locate 'server' configuration setting. Did you provide a --config?")
        end

        @contents
      end
    end
  end
end
