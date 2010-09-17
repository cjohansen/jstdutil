require "jstdutil/jstestdriver/config"
require "jstdutil/jstestdriver/server"
require "jstdutil/cli"
require "jstdutil/test_file"
require "net/http"

module Jstdutil
  class TestRunner
    def initialize(args = [])
      @args = strip_opt(args.join(" "), "tests")
      config = guess_config

      if config && config.server
        @server = JsTestDriver::Server.new(config, args({}, ["port"]).join(" "))
      end
    rescue StandardError => err
      raise err
    end

    def test_cases(files)
      files = files.respond_to?(:captures) ? files.captures : files
      @args = @args.sub(/--reset\s*/, "")

      cases = files.collect do |file|
        @args = @args.sub(/(\s*--reset)?$/, " --reset") if file !~ /_test\.js$/
        TestFile.new(file).test_cases
      end.flatten.join(",")
      
      cases == "" && "all" || cases
    end

    def run(tests = "all")
      puts(Time.now.strftime("%F %H:%M:%S Running #{tests}"))
      puts(Jstdutil::Cli.run(args("tests" => tests)))
    end

    def finalize
      @server.stop
    end

   private
    def guess_config
      config = @args.scan(/--config\s+([^\s]+)/).flatten
      config = config.first || File.expand_path("jsTestDriver.conf")

      if !File.exists?(config)
        config = Dir.glob("**/jstestdriver*.conf", File::FNM_CASEFOLD)
        puts "Using config file #{config[0]}" if config.length > 0
        config = config.length > 0 ? File.expand_path(config[0]) : nil
      end

      raise ArgumentError.new("Unable to guess JsTestDriver config file, please name it jstestdriver*.conf or provide the --config option") if config.nil?

      @args.sub!(/(--config\s+[^\s]+)?/, "--config \"#{config}\" ")

      JsTestDriver::Config.new(config)
    end

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
