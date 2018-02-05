defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "processes test instructions" do
    result = Day10.process_file("resources/input_test.txt")
    #send Map.get(result, "output 0"), { :exit, self() }
    #assert_receive { 5 }, 1
  end
end
