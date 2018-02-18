defmodule Day16Test do
  use ExUnit.Case
  doctest Day16

  test "generates new item" do
    assert Day16.next([1]) == [1,0,0] 
    assert Day16.next([0]) == [0,0,1]
    assert Day16.next([1,1,1,1,0,0,0,0,1,0,1,0]) == [ 1,1,1,1,0,0,0,0,1,0,1,0,0,1,0,1,0,1,1,1,1,0,0,0,0 ]
  end

  test "calculates checksum" do
    assert Day16.checksum([1,1,0,0,1,0,1,1,0,1,0,0]) == [ 1,0,0 ]
  end

  test "example fill 20" do
    assert Day16.fill([1,0,0,0,0], 20) == [1,0,0,0,0,0,1,1,1,1,0,0,1,0,0,0,0,1,1,1]
  end

  test "example checksum" do
    assert Day16.result([1,0,0,0,0], 20) == [0,1,1,0,0]
  end
end
