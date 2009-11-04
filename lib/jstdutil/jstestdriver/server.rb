# require 'open3'
require "uri"

module Jstdutil
  module JsTestDriver
    class Server
      attr_reader :uri

      def initialize(config, args = nil)
        @uri = URI.parse(config.respond_to?(:server) ? config.server : config)
        @args = args
        # @server = nil
        @pid = nil
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
        # @server = IO.popen("jstestdriver #{@args} --port #{@uri.port}")
        # [stdin, stdout, stderr] = Open3.popen3("jstestdriver #{@args} --port #{@uri.port}")
        # @server = stderr

        @pid = Process.fork do
          io = `jstestdriver --port #{@uri.port}`

          Signal.trap("HUP") do
            puts "JsTestDriver at port #@port going down"
            !io.closed? && io.close!
            exit
          end
        end

        # sleep 0.5
      end

      def stop
        # @server && !@server.closed? && @server.close
        if @pid
          Process.kill("HUP", @pid)
          Process.wait
        end
      end
    end
  end
end
