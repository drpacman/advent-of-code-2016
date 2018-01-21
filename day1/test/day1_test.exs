defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "follows navigation right" do
    assert Day1.navigate([0,0], "R2", :north) == { [ 2, 0 ], :east }
    assert Day1.navigate([0,0], "L2", :north) == { [ -2, 0 ], :west }
    assert Day1.navigate([0,0], "R1", :south) == { [ -1, 0 ], :west }
    assert Day1.navigate([0,0], "L1", :south) == { [ 1, 0 ], :east }
    assert Day1.navigate([2,0], "R3", :east) == { [ 2, -3 ], :south }
    assert Day1.navigate([2,0], "L3", :east) == { [ 2, 3 ], :north }
    assert Day1.navigate([1,0], "R4", :west) == { [ 1, 4 ], :north }
    assert Day1.navigate([1,0], "L4", :west) == { [ 1, -4 ], :south }
  end

  test "follows multiple steps" do
    assert Day1.navigate_all([ "R5", "L5", "R5", "R3" ]) == { [ 10, 2 ], :south }
  end

  test "find first duplicate location" do
    assert Day1.find_first_duplicate([ "R8", "R4", "R4", "R8" ]) == [ 4, 0 ]
    assert Day1.find_first_duplicate([ "R2", "L3", "L1", "L1", "L1" ]) == [ 2, 2 ]
    assert Day1.find_first_duplicate([ "L2", "L3", "L1", "L1", "L5" ]) == [ -2, -2 ]
  end

  test "find locations" do
    assert Day1.generate_locations([0,0], [4,0]) == [ [1,0], [2,0], [3,0], [4,0] ]
  end

end
