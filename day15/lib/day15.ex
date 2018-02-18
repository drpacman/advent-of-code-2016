defmodule Day15 do
  @moduledoc """
  Documentation for Day15.
  """

  def get_first_valid_slot(slots) do
    # roll slots by position
    Enum.with_index(slots)
    |> Enum.map(fn({{num, pos}, slot_no}) ->
      { num, rem(pos + slot_no, num) }
    end)
    |> rotate()
  end

  def rotate(slots, step_num \\ 0) do
    updated_slots = Enum.map( slots, fn({ positions, pos }) ->
      { positions, rem(pos+1, positions) }
    end)  
    if Enum.all?(updated_slots, fn({_, pos}) -> pos == 0 end) do
      step_num
    else
      rotate(updated_slots, step_num+1)
    end
  end

  def main(_args) do
    part1 = get_first_valid_slot([ {7,0}, {13,0}, {3,2}, {5,2}, {17,0}, {19,7}])
    IO.puts "Part1 #{part1}"
    part2 = get_first_valid_slot([ {7,0}, {13,0}, {3,2}, {5,2}, {17,0}, {19,7}, {11,0}])
    IO.puts "Part2 #{part2}"
  end
end
