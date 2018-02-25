defmodule Day18Test do
  use ExUnit.Case
  doctest Day18

  test "finds traps (edge cases)" do
    assert Day18.is_trap([0,0,1,1,0], 3) == 1
    assert Day18.is_trap([0,0,1,1,0], 2) == 1
    assert Day18.is_trap([0,0,1,0,0], 3) == 1
  end

  test "finds traps" do
    assert Day18.is_trap([0,0,1,1,0], 4) == 1
    assert Day18.is_trap([0,1,0,0,0], 0) == 1
  end

  test "generates next row" do
    assert Day18.generate_row([0,0,1,1,0]) == [0,1,1,1,1]
  end

  test "generates rows" do
    assert Day18.generate_rows([0,0,1,1,0],2) == [[0,0,1,1,0],[0,1,1,1,1],[1,1,0,0,1]]
  end

  test "counts safe tiles for input and number of rows" do
    assert Day18.count_safe_tiles([0,1,1,0,1,0,1,1,1,1],10) == 38
  end

  test "counts safe tiles (quick) for input and number of rows" do
    assert Day18.count_safe_tiles_inline([0,1,1,0,1,0,1,1,1,1],10) == 38
  end

  test "reads row from file" do
    assert Day18.read_file("resources/input_test.txt") == [ 0,0,1,1,0 ]
  end

end
