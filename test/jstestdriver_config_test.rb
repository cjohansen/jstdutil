require "test_helper"
require "jstdutil/jstestdriver_config"

class JsTestDriverConfigTest < Test::Unit::TestCase
  context "creating JsTestDriverConfig instances" do
    setup do
      @file = "__jstd.conf"
      @server = "http://localhost:4242"
      File.open(@file, "w") { |f| f.puts "server: #{@server}" }
    end

    teardown do
      File.delete(@file) if File.exists?(@file)
    end

    should "work from existing file" do
      config = nil

      assert_nothing_raised do
        config = Jstdutil::JsTestDriverConfig.new @file
      end

      assert_equal @server, config.server
    end

    should "work from string config" do
      config = nil

      assert_nothing_raised do
        config = Jstdutil::JsTestDriverConfig.new "server: #{@server}"
      end

      assert_equal @server, config.server
    end

    should "raise error if no valid configuration is provided" do
      assert_raise ArgumentError do
        Jstdutil::JsTestDriverConfig.new "bogus"
      end
    end
  end
end
