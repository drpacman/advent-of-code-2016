defmodule Day18 do
  @moduledoc """
  Documentation for Day18.
  """

  def is_trap(row, pos) do
    padded_row = [0] ++ row ++ [0]
    case Enum.slice(padded_row, pos, 3) do
      [1,1,0] -> 1
      [0,1,1] -> 1
      [1,0,0] -> 1
      [0,0,1] -> 1
      _ -> 0
    end  
  end

  def generate_row(row) do
    Enum.map 0..Enum.count(row)-1, &(is_trap(row,&1))
  end

  def generate_rows(init,n) do
    Enum.reduce 1..n, [init], fn(_, acc) ->
      acc ++ [ generate_row(Enum.at(acc,-1)) ]
    end
  end

  def count_safe_tiles_inline(row, rows_remaining, safe_count \\ 0) do
    if rows_remaining == 0 do
      safe_count
    else
        count_safe_tiles_inline(generate_row(row), rows_remaining - 1, safe_count + (Enum.filter(row, &(&1 == 0)) |> Enum.count))
    end
  end
  
  def count_safe_tiles(init,total_rows) do
    generate_rows(init, total_rows-1)
    |> Enum.reduce([], &(&2 ++ &1))
    |> Enum.filter(&(&1 == 0))
    |> Enum.count
  end

  def read_file(filename) do
    File.read!(filename)
    |> String.trim
    |> String.to_charlist()
    |> Enum.map(&(if &1==94 do 1 else 0 end))
  end

  def main(_args) do
    IO.inspect generate_rows([0,1,1,0],5)
    input = read_file("resources/input.txt")
    part1 = count_safe_tiles(input, 40)
    IO.puts "Part1 #{part1}"
    part2 = count_safe_tiles_inline(input, 400000)
    IO.puts "Part2 #{part2}"
  end
end
