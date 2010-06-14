require "test_helper"
require "jstdutil/cli"
require "fileutils"

class JstdutilCliTest < Test::Unit::TestCase
  context "running the cli" do
    should "run jstestdriver command through JsRedGreen with given jar" do
      jar = "path/to.jar"
      result = "REPORT"
      Jstdutil.expects(:run).with("--tests all ", jar).returns(result)
      Jstdutil::Formatter.expects(:format).with(result, Jstdutil::RedGreen).returns(result * 2)

      assert_equal result * 2, Jstdutil::Cli.run("--tests all --jar #{jar}".split(" "))
    end

    should "run jstestdriver command through JsRedGreen with jar from env" do
      jar = "path/to.jar"
      result = "REPORT"
      Jstdutil.expects(:jar).returns(jar)
      Jstdutil.expects(:run).with("--tests all", jar).returns(result)
      Jstdutil::Formatter.expects(:format).with(result, Jstdutil::RedGreen).returns(result * 2)

      assert_equal result * 2, Jstdutil::Cli.run("--tests all".split(" "))
    end
    
    should "run jstestdriver command through JsColorfulHtml with --html" do
      jar = "path/to.jar"
      result = "REPORT"
      Jstdutil.expects(:jar).returns(jar)
      Jstdutil.expects(:run).with("--tests all ", jar).returns(result)
      Jstdutil::Formatter.expects(:format).with(result, Jstdutil::ColorfulHtml).returns(result * 2)

      assert_equal result * 2, Jstdutil::Cli.run("--tests all --html".split(" "))
    end
  end
end
