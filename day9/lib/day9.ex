defmodule Day9 do
  @moduledoc """
  Documentation for Day9.
  """

  def repeat(str, n) do
    Enum.reduce 0..n-1, "", fn(x,acc)-> acc <> str end
  end
  
  def next_match(input) do
    case Regex.run(~r/^([^\(]*)\((\d+)x(\d+)\)(.*)$/, input) do
      [ _, head, len, count, tail ] ->
        n = String.to_integer(len)
        section = String.slice(tail, 0..n-1)
        remainder = String.slice(tail, n..-1)
        { head, section, String.to_integer(count), remainder }
      nil ->
        { input }
    end
 end

 def decompress(input) do
    case next_match(input) do
      { head, section, count, remainder } ->
        head <> repeat(section, count) <> decompress(remainder)
      { tail } ->
        tail
    end
  end

 def count_decompressed_size(input) do
    case next_match(input) do
      { head, section, count, remainder } ->
        String.length(head) + count*(count_decompressed_size(section)) + count_decompressed_size(remainder)
      { tail } ->
        String.length(tail)
    end
  end

 def decompress_recur_size(input) do
   count_decompressed_size(input)
  end

  def main(_args) do
    content = File.read!("resources/input.txt") |> String.trim()
    part1 = decompress(content) |> String.length
    IO.puts "Part1 #{part1}"
    part2 = decompress_recur_size(content)
    IO.puts "Part2 #{part2}"
  end
end
