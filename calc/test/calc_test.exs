defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Simple Test Case 1" do
    assert Calc.eval("25+5+6+9") == "45"
  end
  test "Simple Test Case 2" do
    assert Calc.eval("2+3") == "5"
  end
  test "Simple Test Case 3" do
    assert Calc.eval("5*5") == "25"
  end
  test "Simple Test Case 4" do
    assert Calc.eval("9/3") == "3"
  end
  test "Simple Test Case 5" do
    assert Calc.eval("24 / 6 + (5 - 4)") == "5"
  end
  test "Simple Test Case 6" do
    assert Calc.eval("1 + 3 * 3 + 1") == "11"
  end
  test "Nested Test Case" do
    assert Calc.eval("5+(4*3+(4-6*2)+7)+9*11") == "115"
  end
  test "Nested Test Case 2" do
    assert Calc.eval("(5+(4*3+(4-6*2)+7)+9*11)/(24 / 6 + (5 - 4))") == "23"
  end

end
	