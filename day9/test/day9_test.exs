defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "decompress" do
    assert Day9.decompress("A(3x2)BCD") == "ABCDBCD"
    assert Day9.decompress("A(5x2)(1x1)BCD") == "A(1x1)(1x1)BCD"
    assert Day9.decompress("X(8x2)(3x3)ABCY") == "X(3x3)ABC(3x3)ABCY"
  end

  test "decompress recur" do
    assert Day9.decompress_recur_size("X(8x2)(3x3)ABCY") == 20
    assert Day9.decompress_recur_size("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN") == 445
  end
end

