require "test_helper"

class JstdutilCliTest < Test::Unit::TestCase
  def setup
    @bin = File.join(File.dirname(__FILE__), "..", "bin", "jstestdriver")
  end

  context "running the binary" do
    should "report success to $stdout" do
      stdout = capture_stdout do
        jar = "JsTestDriver.jar"

        with_jars(jar) do |dir|
          `#@bin --jar #{File.join(dir, jar)}`
        end
      end

      assert_equal "", stdout
    end

  end
end
