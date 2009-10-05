require "jstdutil/jstestdriver/config"
require "jstdutil/jstestdriver/server"
require "jstdutil/cli"
require "net/http"

module Jstdutil
  class TestRunner
    def initialize(args = [])
      @args = strip_opt(args.join(" "), "tests")
      config = @args.scan(/--config\s+([^\s]+)/).flatten
      config = config.first || File.expand_path("jsTestDriver.conf")
      config = JsTestDriver::Config.new(config)

      if config && config.server
        @server = JsTestDriver::Server.new(config, args({}, ["port"]).join(" "))
      end
    end

    def test_cases(files)
      files = files.respond_to?(:captures) ? files.captures : files
      files.collect { |file| TestFile.new(file).test_cases }.flatten.join(",")
    end

    def run(tests = "all")
      begin
        @server.start unless @server.running?
      rescue StandardError => err
        puts err.message
      end

      puts(Jstdutil::Cli.run(args("tests" => tests)))
    end

    def finalize
      @server.stop
    end

   private
    def args(add = {}, remove = [])
      args = @args
      (remove + add.keys).uniq.each { |opt| args = strip_opt(args, opt) }
      add.each { |opt, value| args += " --#{opt} #{value}" }
      args.strip.split(/\s+/)
    end

    def strip_opt(str, opt)
      str.sub(/--#{opt}\s+[^\s]+/, "")
      str
    end
  end
end
