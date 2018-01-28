defmodule Day6 do
  @moduledoc """
  Documentation for Day6.
  """

  def read_file(filename) do
    File.read!(filename) |> String.trim() |> String.split("\n")
  end

  def pivot(rows) do
    n = String.length hd(rows)
    Enum.map 0..n-1, fn(n)->
      Enum.map(rows, &(String.trim(&1)))
      |> Enum.map(&String.codepoints(&1))
      |> Enum.map(&(Enum.at(&1,n)))
    end
  end

  def most_common_char(chars) do
    common_char(chars, &Enum.max_by/2)
  end
  
  def least_common_char(chars) do
    common_char(chars, &Enum.min_by/2)
  end
  
  def common_char(chars, f) do
    Enum.group_by(chars, (&(&1)))
    |> f.(fn({_,v}) -> Enum.count v end)
    |> elem(0)
  end
  
  def read_columns(filename) do
    read_file(filename) |> pivot()
  end

  def decode_part1(filename) do
    decode(filename, &most_common_char/1)
  end

  def decode_part2(filename) do
    decode(filename, &least_common_char/1)
  end

  def decode(filename, f) do
    read_columns(filename)
    |> Enum.map(&(f.(&1)))
    |> List.to_string()
  end

  def main(_args) do
    part1 = decode_part1("resources/input.txt")
    IO.puts "Part1 #{part1}"
    part2 = decode_part2("resources/input.txt")
    IO.puts "Part2 #{part2}"
  end
end
