defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "navigates to next key" do
    assert Day2.navigate(5, "U") == [ 1, 0 ]
    assert Day2.navigate(2, "U") == [ 1, 0 ]
    assert Day2.navigate(2, "D") == [ 1, 1 ]
    assert Day2.navigate(7, "D") == [ 0, 2 ]
  end

  test "get key code" do
    assert Day2.key_after_seq(5, "ULL") == 1
    assert Day2.key_after_seq(1, "RRDDD") == 9
    assert Day2.key_after_seq(9, "LURDL") == 8
    assert Day2.key_after_seq(8, "UUUUD") == 5
    assert Day2.key_after_seq(3, "LLLDDUDRLDLRLDUDU") == 4
  end

  test "generates key sequence" do
    assert Day2.generate_sequence([ "ULL", "RRDDD", "LURDL", "UUUUD" ]) == [ 1, 9 , 8 , 5 ]
  end

  test "reads input" do
    assert length(Day2.read_input("resources/input_test.txt")) == 4
  end

  test "generate key sequence from file" do
    assert Day2.generate_sequence_from_file( "resources/input_test.txt" ) == [ 1, 9, 8, 5 ]
  end
end
