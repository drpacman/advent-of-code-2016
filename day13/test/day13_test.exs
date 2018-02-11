defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "checks wall correctly" do
    assert Day13.is_wall(1,1, 10) == false
    assert Day13.is_wall(1,0, 10) == true
  end

  test "finds available moves" do
    assert MapSet.new(Day13.available_moves(1,1,10)) == MapSet.new([ {0,1}, {1,2} ])
  end

  test "walks available moves until reaches position" do
    assert Day13.walk(10,[{1,1}],{7,4}) == 11
  end
end
