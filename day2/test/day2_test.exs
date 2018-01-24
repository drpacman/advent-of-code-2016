defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  @part1 { &Day2.navigate_part1/2, &Day2.key_to_grid_part1/1, &Day2.grid_to_key_part1/1 }
  @part2 { &Day2.navigate_part2/2, &Day2.key_to_grid_part2/1, &Day2.grid_to_key_part2/1 }

  test "find correct grid position for part 2" do
    assert Day2.key_to_grid_part2(7) == [ 0, 0 ]
  end
  
  test "find correct key for grid position for part 2" do
    assert Day2.grid_to_key_part2([0,0]) == 7
    assert Day2.grid_to_key_part2([0,2]) == "d"
    assert Day2.grid_to_key_part2([0,1]) == "b"
    assert Day2.grid_to_key_part2([-1,1]) == "a"
  end

  test "navigates to next key for part 2" do
    assert Day2.navigate_part2(7, "U") == [ 0, -1 ]
    assert Day2.navigate_part2(2, "U") == [ -1, -1 ]
    assert Day2.navigate_part2(8, "D") == [ 1, 1 ]
    assert Day2.navigate_part2(13, "U") == [ 0, 1 ]
    assert Day2.navigate_part2(13, "L") == [ 0, 2 ]
    assert Day2.navigate_part2(11, "R") == [ 1, 1 ]
    assert Day2.navigate_part2(4, "L") == [ 0, -1 ]
  end

  test "navigates to next key for part 1" do
    assert Day2.navigate_part1(5, "U") == [ 0, -1 ]
    assert Day2.navigate_part1(2, "U") == [ 0, -1 ]
    assert Day2.navigate_part1(2, "D") == [ 0, 0 ]
    assert Day2.navigate_part1(7, "D") == [ -1, 1 ]
  end

  test "get key code" do
    assert Day2.key_after_seq(5, "ULL", @part1) == 1
    assert Day2.key_after_seq(1, "RRDDD", @part1) == 9
    assert Day2.key_after_seq(9, "LURDL", @part1) == 8
    assert Day2.key_after_seq(8, "UUUUD", @part1) == 5
    assert Day2.key_after_seq(3, "LLLDDUDRLDLRLDUDU", @part1) == 4
  end

  test "generates key sequence" do
    assert Day2.generate_sequence([ "ULL", "RRDDD", "LURDL", "UUUUD" ], 5, @part1) == [ 1, 9 , 8 , 5 ]
  end

  test "reads input" do
    assert length(Day2.read_input("resources/input_test.txt")) == 4
  end

  test "generate key sequence from file" do
    assert Day2.generate_sequence_from_file( "resources/input_test.txt", 5, @part1 ) == [ 1, 9, 8, 5 ]
  end
end
