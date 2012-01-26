require "rake"

module Jstdutil
  # Knows how to map source files to test files, how to extract test cases
  # and so on.
  #
  class TestFile
    def initialize(file)
      @file = file
    end

    def test_files
      return @test_files if @test_files

      if @file =~ /([-_]test[^\/]+)|([^\/]+[-_]test)\.js/
        @test_files = [@file]
      else
        name = File.basename(@file).gsub(/([-_]test)|(test[-_])|(\.js)/, "")
        @test_files = FileList["**/#{name}_test.js",
                               "**/test_#{name}.js",
                               "**/#{name}-test.js",
                               "**/test-#{name}.js",
                               "**/#{camelize(name)}Test.js"].uniq
      end
    end

    def test_cases
      return @cases if @cases

      @cases = test_files.collect do |file|
        File.read(file).scan(/estCase\(["']([^"']*)/)
      end

      @cases.flatten!
    end

    private
    def camelize(str)
      pieces = str.split(/[^a-z0-9]/i)
      pieces.shift + pieces.map { |w| w.capitalize }.join
    end
  end
end
