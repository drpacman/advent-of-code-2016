defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "identify valid triangle" do
    assert Day3.is_valid_triangle([ 3, 4, 5 ])
  end

  test "pivots entries" do
    assert Day3.pivot(Day3.read_input("resources/input_test.txt")) == [ [ 3,5,10,7], [4,1,10,8], [5,2,10,11] ]
  end
                                                                  

  test "identifies valid triangles horizontal" do
    assert Day3.count_valid_triangles_horizontal("resources/input_test.txt") == 3
  end

  test "identifies valid triangles vertical" do
    assert Day3.count_valid_triangles_vertical("resources/input_test.txt") == 2
  end
end
