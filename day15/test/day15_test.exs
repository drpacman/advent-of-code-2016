defmodule Day15Test do
  use ExUnit.Case
  doctest Day15

  test "example slots passes matches at time 5 (simple)" do
    slots = [ { 5, 4 }, { 2, 1 } ]
    assert Day15.get_first_valid_slot(slots) == 5
  end
end
