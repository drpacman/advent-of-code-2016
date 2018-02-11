defmodule Day13 do
  @moduledoc """
  Documentation for Day13.
  """

  def count_bits(value) do
    Enum.count( Integer.digits(value,2), &(&1==1))
  end
  
  def is_wall(x,y,seed) do
    sum = seed + (x*x) + (3*x) + (2*x*y) + y + (y*y)
    rem(count_bits(sum),2) == 1
  end

  def available_moves(x,y,seed) do
    moves = [{ x+1,y },{x-1,y},{x,y+1},{x,y-1}]
    Enum.filter moves, fn({x,y}) -> x>=0 && y>=0 && is_wall(x,y,seed)==false end
  end

  def walk(seed, locations, {x2,y2}, steps \\ 0) do
    if Enum.any?(locations, fn({x1,y1}) -> x1 == x2 && y1 == y2 end) do
      steps
    else
      next = Enum.reduce(locations, [], fn({x1,y1},acc) -> acc ++ available_moves(x1,y1,seed) end)
      unique_next = MapSet.new(next)
      walk(seed, MapSet.to_list(unique_next), {x2,y2}, steps+1)
    end
  end

  def wander(seed, locations, max_steps) do
    wander(seed, locations, max_steps, 0, MapSet.new(locations))
  end
  
  def wander(seed, locations, max_steps, steps, history) do
    if steps == max_steps do
      Enum.count history
    else
      next = Enum.reduce(locations, [], fn({x1,y1},acc) -> acc ++ available_moves(x1,y1,seed) end)
      new_next = MapSet.difference(MapSet.new(next), history)
      wander(seed, MapSet.to_list(new_next), max_steps, steps+1, MapSet.union(history, new_next))
    end
  end

  def main(_args) do
    part1 = walk(1364, [{1,1}],{31,39})
    IO.puts "Part1 is #{part1}"
    part2 = wander(1364, [{1,1}],50)
    IO.puts "Part2 is #{part2}"
  end
end
