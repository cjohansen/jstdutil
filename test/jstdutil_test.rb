require "test_helper"

class JstdutilTest < Test::Unit::TestCase
  context "locating jar file" do
    setup do
      @newest = "jstestdriver-1.1.jar"
      @jars = ["JsTestDriver-1.0b.jar", "jstestdriver-1.0.jar", @newest]
    end

    should "use most recent test driver" do
      with_jars(@jars) do |dir|
        assert_equal @newest, File.basename(Jstdutil.jar(dir))
      end
    end

    should "use $JSTESTDRIVER_HOME if no classpath is given" do
      with_jars(@jars) do |dir|
        with_env("JSTESTDRIVER_HOME", dir) do
          assert_equal @newest, File.basename(Jstdutil.jar)
        end
      end
    end

    should "raise exception if no classpath is provided, and env not set" do
      with_env("JSTESTDRIVER_HOME", nil) do
        assert_raise FileNotFoundError do
          Jstdutil.jar
        end
      end
    end
  end
end
