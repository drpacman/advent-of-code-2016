defmodule Day3 do
  @moduledoc """
  Documentation for Day3.
  """
  def read_input(filename) do
    File.read!(filename)
    |> String.trim()
    |> String.split("\n")
    |> parse_lines()
  end

  def parse_lines( lines ) do
    Enum.map lines, fn(line) ->
      case Regex.run(~r/ *(\d+) *(\d+) *(\d+)/, line) do
        [_,x,y,z] ->
          Enum.map([x,y,z], &(String.to_integer &1))
      end
    end
  end
  
  def pivot(horizontal_entries) do
    Enum.map 0..2, fn(n)->
      Enum.map(horizontal_entries, &(Enum.at(&1,n)))
    end
  end
  
  def count_valid_triangles_horizontal(filename) do
    read_input(filename)
    |> count_valid_triangles
  end
  
  def count_valid_triangles_vertical(filename) do
    read_input(filename)
    |> split_by_columns
    |> count_valid_triangles
  end

  def split_by_columns(horizontal_entries) do
    pivot(horizontal_entries)
    |> Enum.reduce(&(Enum.concat(&2,&1)))
    |> Enum.chunk_every(3)
  end
  
  def count_valid_triangles(candidates) do
    Enum.reduce(
      candidates,
      0,
      fn(sides, acc) ->
        if (is_valid_triangle(sides)) do
          acc + 1
        else
          acc
        end
      end
    )
  end

  def is_valid_triangle(sides) do
    [x,y,z] = Enum.sort(sides)
    x+y > z
  end

  def main(_args) do
    part1 = count_valid_triangles_horizontal("resources/input.txt")
    IO.puts "Part 1 #{part1}"
    part2 = count_valid_triangles_vertical("resources/input.txt")
    IO.puts "Part 2 #{part2}"
  end
end
