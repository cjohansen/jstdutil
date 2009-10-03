require "jstdutil/jstestdriver_config"
require "jstdutil/cli"
require "net/http"

module Jstdutil
  class TestRunner
    def initialize(args = [])
      @args = strip_opt(args.join(" "), "tests")
      config = @args.scan(/--config\s+([^\s]+)/).flatten
      config = config.first || File.expand_path("jsTestDriver.conf")

      begin
        @server = URI.parse(JsTestDriverConfig.new(config).server)
        start_server unless server_running?
      rescue StandardError => err
        puts err.inspect
        $stdout.puts("No valid configuration available, skipping server check/startup")
      end
    end

    def test_files(files)
      file.each do |file|
        run(TestFile.new(file).test_cases)
      end
    end

    def run(tests = "all")
      $stdout.puts(Jstdutil::Cli.run(args("tests" => tests)))
    end

    def server_running?
      response = nil

      begin
        Net::HTTP.start(@server.host, @server.port) { |http| response = http.head("/") }
      rescue Errno::ECONNREFUSED => err
        return false
      end

      response.code == "200"
    end

    def start_server
      if !["localhost", "127.0.0.1", "0.0.0.0"].include?(@server.host)
        $stdout.puts "Unable to start remote server on #{@server.localhost}"
        return
      end

      IO.popen("jstestdriver #{args("port" => @server.port).join(' ')}")
    end

    def args(add = {}, remove = [])
      args = @args
      (remove + add.keys).uniq.each { |opt| args = strip_opt(args, opt) }
      add.each { |opt, value| args += " --#{opt} #{value}" }
      args.strip.split(/\s+/)
    end

   private
    def strip_opt(str, opt)
      str.sub(/--#{opt}\s+[^\s]+/, "")
      str
    end
  end
end
