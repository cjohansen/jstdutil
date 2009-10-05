module Jstdutil
  module JsTestDriver
    class Server
      def initialize(config, args)
        @uri = URI.parse(config.server)
        @args = args
        @server = nil
      end

      def running?
        response = nil

        begin
          Net::HTTP.start(@uri.host, @uri.port) { |http| response = http.head("/") }
        rescue Errno::ECONNREFUSED => err
          return false
        end

        response.code == "200"
      end

      def start
        if !["localhost", "127.0.0.1", "0.0.0.0"].include?(@uri.host)
          raise "Unable to start remote server on #{@uri.host}"
        end

        puts "Starting server on http://#{@uri.host}:#{@uri.port}"
        @server = IO.popen("jstestdriver #{@args} --port #{@uri.port}")
        sleep 0.5
      end

      def stop
        @server && !@server.closed? && @server.close
      end
    end
  end
end
