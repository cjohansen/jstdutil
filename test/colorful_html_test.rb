require "test_helper"

class ColorfulHtmlTest < Test::Unit::TestCase
  context "adding pretty colors" do

    should "wrap in green" do
      assert_equal "<span class='green'>trees</span>", Jstdutil::ColorfulHtml::Color.green("trees")
    end

    should "wrap in red" do
      assert_equal "<span class='red'>dress</span>", Jstdutil::ColorfulHtml::Color.red("dress")
    end

  end
  
  context "wrapping report" do
    
    should "add styles and pre" do
      assert_equal "<style>.red {color: #c00;} .green {color: #0c0;} .yellow {color: #ff0;} </style><pre>present</pre>",
                   Jstdutil::ColorfulHtml.wrap_report("present")
    end
    
  end
  
end
