defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "generates MD5 hash of base and number and returns 6th char if first 5 are 0" do
    assert Day5.calculate_value_part1("abc", 0) == { false, nil } 
    assert Day5.calculate_value_part1("abc", 3231929) == { true, "1" } 
  end

  test "generates code part1" do
    assert Day5.calculate_code_part1("abc", 3) == "18f"
  end

  test "updates pos part2" do
    assert Day5.update_code("___", 0, "1") == "1__"
    assert Day5.update_code("___", 1, "1") == "_1_"
    assert Day5.update_code("___", 2, "1") == "__1"
  end

end
