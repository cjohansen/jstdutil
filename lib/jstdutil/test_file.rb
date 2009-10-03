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

      if @file =~ /(_test[^\/]+)|([^\/]+_test)\.js/
        @test_files = [@file]
      else
        name = File.basename(@file).gsub(/(_test)|(test_)|(\.js)/, "")
        @test_files = FileList["**/#{name}_test.js", "**/test_#{name}.js"].uniq
      end
    end

    def test_cases
      return @cases if @cases

      @cases = test_files.collect do |file|
        File.read(file).scan(/TestCase\(["']([^"']*)/)
      end

      @cases.flatten!
    end
  end
end
