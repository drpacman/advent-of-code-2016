defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "reads columns from file" do
    assert Day6.read_columns("resources/input_test.txt") == [ [ "1", "4", "7" ], [ "2","5","8" ], [ "3","6","9" ] ]
  end

  test "finds most popular letter in a column" do
    assert Day6.most_common_char(["a","b","a","c"]) == "a"
  end

  test "finds least popular letter in a column" do
    assert Day6.least_common_char(["a","b","a","c"]) == "b"
  end

  test "finds code for part1" do
    assert Day6.decode_part1("resources/input_test_example.txt") == "easter"
  end

  test "finds code for part2" do
    assert Day6.decode_part2("resources/input_test_example.txt") == "advent"
  end
end
