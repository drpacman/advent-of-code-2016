defmodule Day8Test do
  use ExUnit.Case
  doctest Day8

  @screen MapSet.new()

  test "merges rect" do
    assert Day8.rect(@screen, 2, 3) == Enum.into( [{0,0}, {0,1}, {1,0}, {1,1}, {0,2}, {1,2}], MapSet.new() )
  end

  test "rotate row" do
    assert Day8.rotate_row(MapSet.new([{48,1},{49,1},{49,2}]),1,1,50) == MapSet.new([{49,1}, {0,1}, {49,2}])
    assert Day8.rotate_row(MapSet.new([{48,1},{49,1},{49,2}]),2,1,50) == MapSet.new([{48,1}, {49,1}, {0,2}])
  end

  test "rotate col" do
    assert Day8.rotate_col(MapSet.new([{1,1},{2,1},{1,5}]),1,1,6) == MapSet.new([{1,2}, {1,0}, {2,1}])
  end

  test "example part1" do
    r = Day8.rect(@screen,3,2)
    |> Day8.rotate_col(1,1,3)
    |> Day8.rotate_row(0,4,7)
    |> Day8.rotate_col(1,1,3)
    assert r == MapSet.new([{1,0},{4,0},{6,0},{0,1},{2,1},{1,2}])
  end
end
