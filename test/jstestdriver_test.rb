require "test_helper"

class JstdutilCliTest < Test::Unit::TestCase
  def setup
    @bin = File.join(File.dirname(__FILE__), "..", "bin", "jstestdriver")
  end

  context "running the binary" do
    should "report success to $stdout" do
      jar = "JsTestDriver.jar"
      stdout = nil

      capture_stderr do
        stdout = capture_stdout do
          with_jars(jar) do |dir|
            `ruby -Ilib #@bin --jar #{File.join(dir, jar)}`
          end
        end
      end

      assert_equal "\n", stdout
    end
  end
end
