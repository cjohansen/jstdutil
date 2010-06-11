require "test_helper"

class ColorfulHtmlTest < Test::Unit::TestCase
  context "wrapping in colors" do

    should "wrap in green" do
      assert_equal "<span style='color: green;'>trees</span>", Jstdutil::ColorfulHtml::Color.green("trees")
    end

    should "wrap in red" do
      assert_equal "<span style='color: red;'>dress</span>", Jstdutil::ColorfulHtml::Color.red("dress")
    end

  end
end
