require "test_helper"

class RedGreenTest < Test::Unit::TestCase
  context "adding pretty colors" do

    should "wrap in green" do
      assert_equal "\e[32mtrees\e[0m", Jstdutil::RedGreen::Color.green("trees")
    end

    should "wrap in red" do
      assert_equal "\e[31mdress\e[0m", Jstdutil::RedGreen::Color.red("dress")
    end

  end
  
  context "wrapping report" do

    should "add nothing" do
      assert_equal "bare", Jstdutil::RedGreen.wrap_report("bare")
    end

  end
end
