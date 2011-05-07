require "test_helper"
require "jstdutil/test_file"
require "fileutils"

class TestFileTest < Test::Unit::TestCase
  context "test files" do
    should "be file itself if name is like _test.js" do
      file = "some_test.js"
      test_file = Jstdutil::TestFile.new(file)

      assert_equal [file], test_file.test_files
    end

    should "find files like _test.js" do
      file = "some.js"
      test_file = Jstdutil::TestFile.new(file)
      FileList.expects(:new).with("**/some_test.js", "**/test_some.js", "**/some-test.js", "**/test-some.js").returns([])

      assert test_file.test_files
    end
  end

  context "test cases" do
    setup do
      @dir = "__testdata"
      @files = ["src/some.js", "test/some_test.js", "test/other_test.js"]
      @cases = ["SomeTest", "OtherTest", "YetAnotherTest"]
      @contents = { @files[1] => 'new TestCase("' + @cases[0] + '", {});',
                    @files[2] => "new TestCase('#{@cases[1]}', {});\nnew TestCase('#{@cases[2]}', {});" }

      @files.each do |file|
        content = @contents[file] || ""
        file = File.join(@dir, file)
        FileUtils.mkdir_p(File.dirname(file))
        File.open(file, "w") { |f| f.puts(content) }
      end
    end

    teardown do
      FileUtils.rm_rf(@dir)
    end

    should "find test case in file" do
      test_file = Jstdutil::TestFile.new(@files[0])

      assert_equal @cases[0..0], test_file.test_cases
    end
  end
end
